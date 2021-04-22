import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prayer_location_finder_app/model/user_model.dart';
import 'package:prayer_location_finder_app/model/maslak_model.dart';

class UserDetails extends StatefulWidget {
  UserDetails({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  Future<MaslakModel> maslakModel;
  String _mySelection;
  final _formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    maslakModel = getMaslaks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text('Enter Your Details'),
        ),
        body: Center(
          child: Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(15.0),
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
                            labelText: 'Enter Your UserName',
                            icon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        color: Colors.white,
                        child: FutureBuilder<MaslakModel>(
                          future: maslakModel,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: new DropdownButton(
                                      items: x.map((data) {
                                        return new DropdownMenuItem(
                                          child: new Text(snapshot.data.name),
                                          value: snapshot.data.mId.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          snapshot.data.mId = newVal;
                                        });
                                      },
                                      value: snapshot.data.name.toString(),
                                    ),
                                  ),
                                ],
                              );
                            } else
                              return CircularProgressIndicator();
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CarouselWithIndicatorDemo(),
                              ),
                            );
                            CircularProgressIndicator();
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  List x = List();
  Future<MaslakModel> getMaslaks() async {
    var client = http.Client();
    var maslakModel = null;

    try {
      var response = await client.get(Strings.api_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        maslakModel = MaslakModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return maslakModel;
    }
    return maslakModel;
  }
}

class Strings {
  static String api_url = 'https://localhost:44355/api/maslaks';
}
