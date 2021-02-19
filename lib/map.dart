import 'dart:ui';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:location/location.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyDqwUf8f05X7XztGJtCkaQ1LmbIeFzgwrI";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
final LatLng _center = const LatLng(24.8607, 67.0011);
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

  GoogleMapController mapController;

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
        body: Stack(
          children: [
            SafeArea(
              child: GoogleMap(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 135) +
                    MediaQuery.of(context).padding,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                ),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,
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
                  Container(
                    padding: EdgeInsets.only(
                      top: .0,
                    ),
                    child: RaisedButton(
                      padding: EdgeInsets.all(20),
                      color: Colors.green,
                      onPressed: _handlePressButton,
                      child: Text(
                        "Search places",
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
