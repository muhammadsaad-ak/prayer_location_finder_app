import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:prayer_location_finder_app/mosque_list_screen.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:prayer_location_finder_app/retrofit/apis.dart';
import 'main.dart';
import 'map.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:adhan/adhan.dart';
import 'package:location/location.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';
import 'package:dio/dio.dart';
import 'package:prayer_location_finder_app/model/data.dart';
import 'package:prayer_location_finder_app/retrofit/api_client.dart';
import 'app_repository.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hijri/digits_converter.dart';
import 'package:hijri/hijri_array.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          // padding: EdgeInsets.only(top: 30),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(1.0),
            child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1500),
                    Positioned(
                      // top: 50.0,
                      // bottom: 0.0,
                      // left: 0.0,
                      // right: 0.0,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        // padding: EdgeInsets.symmetric(
                        //     vertical: 10.0, horizontal: 20.0),
                        // child: Text(
                        //   'No. ${imgList.indexOf(item)} image',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 20.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class CarouselWithIndicatorDemo extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  FutureBuilder<ResponseData> _buildBody(BuildContext context) {
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder<ResponseData>(
      future: client.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final ResponseData data = snapshot.data;
          return _IslamicDate(context, data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  int _current = 0;

  // var now = new DateTime.now();
  // var formatter = new DateFormat('yyyy-MM-dd');
  String _timeString;
  int _hour;
  int _min;
  int _sec;
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;
  // Animation<Duration> animation;
  // Animation<Duration> animation2;
  // Animation<Duration> animation3;
  // Animation<Duration> animation4;
  // Animation<Duration> animation5;
  // AnimationController controller;
  // AnimationController controller2;
  // AnimationController controller3;
  // AnimationController controller4;
  // AnimationController controller5;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  int _getSysTime3() {
    final String formattedDateTime3 = DateFormat('dd-MMM-yyyy | hh:mm:ss')
        .format(DateTime.now())
        .split('|')[1]
        .split(':')[2];

    _sec = int.parse(formattedDateTime3);
    print(_sec);
    return _sec;
  }

  int _getSysTime2() {
    final String formattedDateTime2 = DateFormat('dd-MMM-yyyy | hh:mm:ss')
        .format(DateTime.now())
        .split('|')[1]
        .split(':')[1];

    _min = int.parse(formattedDateTime2);
    print(_min);
    return _min;
  }

  int _getSysTime() {
    final String formattedDateTime1 = DateFormat('dd-MMM-yyyy | hh:mm:ss')
        .format(DateTime.now())
        .split('|')[1]
        .split(':')[0];

    _hour = int.parse(formattedDateTime1);
    print(_hour);
    return _hour;
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('dd-MMM-yyyy | hh:mm:ss').format(DateTime.now()).toString();
    setState(() {
      _timeString = formattedDateTime;
      print(_timeString);
    });
  }

  final location = new Location();
  String locationError;
  PrayerTimes prayerTimes;

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  void startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    // controller = new AnimationController(
    //     duration: new Duration(
    //   hours: prayerTimes.fajr.hour % 12 - _hour,
    //   minutes: prayerTimes.fajr.minute % 12 - _min,
    // ));
    // controller2 = new AnimationController(
    //     duration: new Duration(
    //   hours: prayerTimes.isha.hour % 12 - _hour,
    //   minutes: prayerTimes.isha.minute % 12 - _min,
    // ));
    // controller3 = new AnimationController(
    //     duration: new Duration(
    //   hours: prayerTimes.isha.hour % 12 - _hour,
    //   minutes: prayerTimes.isha.minute % 12 - _min,
    // ));
    // controller4 = new AnimationController(
    //     duration: new Duration(
    //   hours: prayerTimes.isha.hour % 12 - _hour,
    //   minutes: prayerTimes.isha.minute % 12 - _min,
    // ));
    // controller5 = new AnimationController(
    //   duration: new Duration(
    //     hours: prayerTimes.isha.hour % 12 - _hour,
    //     minutes: prayerTimes.isha.minute % 12 - _min,
    //   ),
    // );
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.karachi.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });
    // sequenceAnimation = SequenceAnimationBuilder()
    //     .addAnimatable(
    //         animatable: new Tween<double>(
    //             begin: _hour.roundToDouble() * 3600 +
    //                 _min.roundToDouble() * 60 +
    //                 _sec.roundToDouble(),
    //             end: prayerTimes.maghrib.hour.roundToDouble() * 3600 +
    //                 prayerTimes.maghrib.minute.roundToDouble() * 60 +
    //                 prayerTimes.maghrib.second.roundToDouble()))
    //     .animate(controller);
    //     .addAnimatable(
    //     animatable: new Tween<Duration>(begin:  )
    //
    // ).addAnimatable(
    //     animatable: new Tween<Duration>(begin: 200.0, end: 40.0)
    // ).animate(controller);

    // controller.forward();
    // new Timer(const Duration(milliseconds: 300), () {
    //   controller2.forward();
    // });
    // new Timer(const Duration(milliseconds: 600), () {
    //   controller3.forward();
    // });

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    startTimeout();
    // Dio dio;
    // _IslamicDate = ApiClient(dio).getData();
    super.initState();
  }

  // Future<ResponseData> _IslamicDate;

  @override
  Widget build(BuildContext context) {
    var hDate = new HijriCalendar.fromDate(new DateTime.now());
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;
    params.adjustments.fajr = 2;
    String locale = 'ar';
    HijriCalendar _today = new HijriCalendar.now();
    HijriCalendar.setLocal(locale);
    DateTime now = new DateTime.now();
    String time = "${now.hour}:${now.minute}:${now.second}";
    DateTime date = new DateTime(now.day, now.month, now.year);

    return Material(
      child: Expanded(
        child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.green,
            title: Text('Namaz Timings'),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Map();
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            child: Column(children: [
              Container(
                padding: EdgeInsets.only(top: 0),
                child: CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    autoPlay: true,
                    aspectRatio: 16 / 8,
                    onPageChanged: (index, reason) {
                      if (this.mounted) {
                        setState(() {
                          _current = index;
                        });
                      }
                    },
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Container(
                      width: 178,
                      height: 48,
                      color: Colors.black,
                      child: Center(
                        child: AutoSizeText(
                          _timeString.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(10),
                      // height: 50,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Container(
                          color: Colors.black,
                          width: 178,
                          height: 48,
                          margin: EdgeInsets.all(2),
                          child: Center(
                            child: AutoSizeText(
                              "${hDate.fullDate().toString()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: SizedBox.fromSize(
                  child: Container(
                    // padding: EdgeInsets.only(top: 72),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              child: Builder(
                                builder: (BuildContext context) {
                                  if (prayerTimes != null) {
                                    return AutoSizeText(
                                      'Fajr \n' +
                                          DateFormat.jm()
                                              .format(prayerTimes.fajr),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  if (locationError != null) {
                                    return Text(locationError);
                                  }
                                  return Text('Waiting for Your Location...');
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              // widthFactor: 1.611,
                              child: Builder(
                                builder: (BuildContext context) {
                                  if (prayerTimes != null) {
                                    return AutoSizeText(
                                      'Dhuhr \n' +
                                          DateFormat.jm()
                                              .format(prayerTimes.dhuhr),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  if (locationError != null) {
                                    return Text(locationError);
                                  }
                                  return Text('Waiting for Your Location...');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.fromSize(
                  child: Container(
                    // padding: EdgeInsets.only(top: 72),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              child: Builder(
                                builder: (BuildContext context) {
                                  if (prayerTimes != null) {
                                    return AutoSizeText(
                                      'Asr \n' +
                                          DateFormat.jm()
                                              .format(prayerTimes.asr),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  if (locationError != null) {
                                    return Text(locationError);
                                  }
                                  return Text('Waiting for Your Location...');
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              child: Builder(
                                builder: (BuildContext context) {
                                  if (prayerTimes != null) {
                                    return AutoSizeText(
                                      'Maghrib \n' +
                                          DateFormat.jm()
                                              .format(prayerTimes.maghrib),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  if (locationError != null) {
                                    return Text(locationError);
                                  }
                                  return Text('Waiting for Your Location...');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.fromSize(
                  child: Container(
                    // padding: EdgeInsets.only(top: 72),
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                              child: Builder(
                                builder: (BuildContext context) {
                                  if (prayerTimes != null) {
                                    return AutoSizeText(
                                      'Isha \n' +
                                          DateFormat.jm()
                                              .format(prayerTimes.isha),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  }
                                  if (locationError != null) {
                                    return Text(locationError);
                                  }
                                  return Text('Waiting for Your Location...');
                                },
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            color: Colors.green,
                            child: Center(
                                // child: TweenAnimationBuilder<Duration>(
                                //     duration: Duration(
                                //       hours: prayerTimes.maghrib.hour % 12 -
                                //           _getSysTime() % 12,
                                //       minutes: prayerTimes.maghrib.minute % 12 -
                                //           _getSysTime2() % 12,
                                //       seconds: prayerTimes.maghrib.second % 12 -
                                //           _getSysTime3() % 12,
                                //     ),
                                //     tween: Tween(
                                //         begin: Duration(
                                //           hours: _getSysTime() -
                                //               prayerTimes.maghrib.hour % 12,
                                //           minutes: _getSysTime2() -
                                //               prayerTimes.maghrib.minute % 12,
                                //           // seconds: _getSysTime3() -
                                //           //     prayerTimes.maghrib.second % 12,
                                //         ),
                                //         end: Duration.zero),
                                //     onEnd: () {
                                //       print('Timer Ended');
                                //     },
                                //     builder: (BuildContext context,
                                //         Duration value, Widget child) {
                                //       final hours = value.inHours;
                                //       final minutes = value.inMinutes % 60;
                                //       final seconds = value.inSeconds % 60;
                                //       return Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               vertical: 5),
                                //           child: Text(
                                //               'Time Left \n $hours:$minutes:$seconds',
                                //               textAlign: TextAlign.center,
                                //               style: TextStyle(
                                //                   color: Colors.white,
                                //                   fontWeight: FontWeight.bold,
                                //                   fontSize: 25)));
                                //     }),
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _IslamicDate(BuildContext context, ResponseData data) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: Text("${data.data.hijri.date.toString()}"),
        );
      },
      itemCount: data.data.hijri.date.length,
    );
  }
}
