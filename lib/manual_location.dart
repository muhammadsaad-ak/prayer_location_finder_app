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
import 'package:prayer_location_finder_app/model/apiinfo.dart';
import 'package:prayer_location_finder_app/services/api_manager.dart';
import 'user_details.dart';

class ManualLocation extends StatefulWidget {
  ManualLocation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ManualLocationState createState() => _ManualLocationState();
}

class _ManualLocationState extends State<ManualLocation> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyBB14A2BN2cudYScIVIDyn4JODrVwrHtcM";
    String type = '(places)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(request);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manual Location"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UserDetails();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.group,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Seek your location here",
                  focusColor: Colors.white,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: Icon(Icons.map),
                  suffixIcon: IconButton(
                    onPressed: _controller.clear,
                    icon: Icon(
                      Icons.cancel,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(_placeList[index]["description"]),
                    ),
                  );
                },
              ),
              // ListView.builder(
              //   physics: AlwaysScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: _placeList.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text(_placeList[index]["description"]),
              //     );
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
