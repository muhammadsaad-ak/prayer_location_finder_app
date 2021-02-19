import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prayer_location_finder_app/address_search.dart';
import 'package:prayer_location_finder_app/place_service.dart';
import 'package:google_maps_webservice/geolocation.dart';
// import 'package:prayer_location_finder_app/map.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCustomForm extends StatefulWidget {
  MyCustomForm({Key key, this.title}) : super(key: key);

  final String title;
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // String displayName = "${Map.kInitialPosition}";
  // var _controller = TextEditingController();
  // var uuid = new Uuid();
  // String _sessionToken;
  // List<dynamic> _placeList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _controller.addListener(() {
  //     _onChanged();
  //   });
  // }
  //
  // _onChanged() {
  //   if (_sessionToken == null) {
  //     setState(() {
  //       _sessionToken = uuid.v4();
  //     });
  //   }
  //   getSuggestion(_controller.text);
  // }
  //
  // void getSuggestion(String input) async {
  //   String kPLACES_API_KEY = "AIzaSyDqwUf8f05X7XztGJtCkaQ1LmbIeFzgwrI";
  //   String type = '(regions)';
  //   String baseURL =
  //       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  //   String request =
  //       '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
  //   var response = await http.get(request);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _placeList = json.decode(response.body)['predictions'];
  //     });
  //   } else {
  //     throw Exception('Failed to load predictions');
  //   }
  // }
  Location _location = Location(24.8607, 67.0011);
  final _controller = TextEditingController();
  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';
  final _formKey = GlobalKey<FormState>();
  set doubleVar(double doubleVar) {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final myController = TextEditingController();
    return Expanded(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text('Mosque Registration'),
        ),
        body: Center(
          child: Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Representative Name',
                            icon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            Pattern pattern = r'^[A-Za-z]+(?:[ ][A-Za-z]+)*$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value))
                              return 'Invalid Input';
                            else {
                              return value.length < 3
                                  ? 'Name must be greater than three characters'
                                  : null;
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Enter Mosque Name',
                              icon: Icon(FontAwesomeIcons.mosque),
                            ),
                            validator: (value) {
                              Pattern pattern = r'^[A-Za-z]+(?:[ ][A-Za-z]+)*$';
                              RegExp regex = new RegExp(pattern);
                              if (!regex.hasMatch(value))
                                return 'Invalid Input';
                              else {
                                return value.length < 3
                                    ? 'Name must be greater than three characters'
                                    : null;
                              }
                            }),
                      ),
                      Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextFormField(
                                controller: _controller,
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _controller.text = _location.toString();
                                    },
                                    icon: Icon(Icons.my_location),
                                  ),
                                  labelText: 'Enter Location of Mosque',
                                  icon: Icon(Icons.map),
                                ),
                                onTap: () async {
                                  // generate a new token here
                                  final sessionToken = Uuid().v4();
                                  final Suggestion result = await showSearch(
                                    context: context,
                                    delegate: AddressSearch(sessionToken),
                                  );
                                  // This will change the text displayed in the TextField
                                  if (result != null) {
                                    final placeDetails = await PlaceApiProvider(
                                            sessionToken)
                                        .getPlaceDetailFromId(result.placeId);
                                    setState(() {
                                      _controller.text = result.description;
                                      _streetNumber = placeDetails.streetNumber;
                                      _street = placeDetails.street;
                                      _city = placeDetails.city;
                                      _zipCode = placeDetails.zipCode;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                              // ListView.builder(
                              //   physics: NeverScrollableScrollPhysics(),
                              //   shrinkWrap: true,
                              //   itemCount: _placeList.length,
                              //   itemBuilder: (context, index) {
                              //     return ListTile(
                              //       title: Text(_placeList[index]["description"]),
                              //     );
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Enter Phone Number',
                            hintText: '3000000000',
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('+92'),
                            ),
                            icon: Icon(Icons.phone),
                          ),
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[0-9.,]+')),
                          ],
                          onChanged: (value) => doubleVar = double.parse(value),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a number';
                            } else {
                              return value.length < 10
                                  ? 'Enter at least 10 digits'
                                  : null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 100),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              Scaffold.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 20.0),
                // Text('Street Number: $_streetNumber'),
                // Text('Street: $_street'),
                // Text('City: $_city'),
                // Text('ZIP Code: $_zipCode'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
