import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:location/location.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'mosque_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:prayer_location_finder_app/model/directions_model.dart';
import 'package:prayer_location_finder_app/model/directions_repository.dart';

const kGoogleApiKey = "AIzaSyBB14A2BN2cudYScIVIDyn4JODrVwrHtcM";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

//
// final customTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   accentColor: Colors.redAccent,
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4.00)),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 5.50,
//       horizontal: 10.00,
//     ),
//   ),
// );

class Map extends StatefulWidget {
  const Map({Key key}) : super(key: key);
  static final kInitialPosition = LatLng(24.8607, 67.0011);
  @override
  _MapState createState() => _MapState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class _MapState extends State<Map> {
  // GoogleMapController mapController;
  // final Set<Marker> _markers = new Set();
  //
  // final ThemeData lightTheme = ThemeData.light().copyWith(
  //   // Background color of the FloatingCard
  //   cardColor: Colors.white,
  //   buttonTheme: ButtonThemeData(
  //     // Select here's button color
  //     buttonColor: Colors.black,
  //     textTheme: ButtonTextTheme.primary,
  //   ),
  // );
  //
  // final ThemeData darkTheme = ThemeData.dark().copyWith(
  //   // Background color of the FloatingCard
  //   cardColor: Colors.grey,
  //   buttonTheme: ButtonThemeData(
  //     // Select here's button color
  //     buttonColor: Colors.yellow,
  //     textTheme: ButtonTextTheme.primary,
  //   ),
  // );

  // LatLng _initialcameraposition = LatLng(24.8607, 67.0011);
  // GoogleMapController _controller;
  // Location _location = Location(24.8607, 67.0011);
  //
  // void _onMapCreated(GoogleMapController _cntlr) {
  //   _controller = _cntlr;
  //   _location.onLocationChanged.listen((l) {
  //     _controller.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
  //       ),
  //     );
  //   });
  // }
  static const _initialCameraPosition = CameraPosition(
    zoom: 11.5,
    target: LatLng(24.8607, 67.0011),
  );
  GoogleMapController mapController;
  Marker _origin;
  Marker _destination;
  Directions _info;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Mode _mode = Mode.overlay;

  PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        key: homeScaffoldKey,
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Google Maps'),
          actions: [
            if (_origin != null)
              TextButton(
                onPressed: () => mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _origin.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('ORIGIN'),
              ),
            if (_destination != null)
              TextButton(
                onPressed: () => mapController.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: _destination.position,
                      zoom: 14.5,
                      tilt: 50.0,
                    ),
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: const Text('DEST'),
              )
          ],
        ),
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: GoogleMap(
                // markers: Set.from({selectedPlace.photos}),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 135) +
                    MediaQuery.of(context).padding,
                onMapCreated: (controller) => mapController = controller,
                initialCameraPosition: _initialCameraPosition,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                compassEnabled: false,
                zoomControlsEnabled: false,
                markers: {
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                },
                polylines: {
                  if (_info != null)
                    Polyline(
                      polylineId: PolylineId('overview_polyline'),
                      color: Colors.red,
                      width: 5,
                      points: _info.polylinePoints
                          .map((e) => LatLng(e.latitude, e.longitude))
                          .toList(),
                    ),
                },
                onLongPress: _addMarker,
              ),
            ),
            if (_info != null)
              Positioned(
                top: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Text(
                    '${_info.totalDistance}, ${_info.totalDuration}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            // _buildDropdownMenu(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white38,
                    child: SizedBox(
                      height: 42,
                      child: Text(
                        '$selectedPlace',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          elevation: 50,
                          padding: EdgeInsets.all(23),
                          color: Colors.green,
                          onPressed: _handlePressButton,
                          child: Text(
                            "Search places",
                            style: TextStyle(
                              fontSize: 27,
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        elevation: 50,
                        padding: EdgeInsets.all(26),
                        color: Colors.lightGreen,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MosqueList();
                              },
                            ),
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.mosque,
                          size: 27.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              onPressed: () => mapController.animateCamera(
                _info != null
                    ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
                    : CameraUpdate.newCameraPosition(_initialCameraPosition),
              ),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: Colors.green,
              child: const Icon(Icons.center_focus_strong, size: 36.0),
            ),
          ),
        ),
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "fr",
      components: [Component(Component.country, "pk")],
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
  }
}

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "pk")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
