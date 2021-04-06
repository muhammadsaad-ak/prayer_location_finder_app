import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:custom_switch/custom_switch.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class Filters {
  const Filters(this.name1, this.initials1);
  final String name1;
  final String initials1;
}

class CastFilter extends StatefulWidget {
  @override
  State createState() => CastFilterState();
}

class CastFilterState extends State<CastFilter> {
  bool status = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  double _currentSliderValue = 5;
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('Sunni', 'Su'),
    const ActorFilterEntry('Shia', 'Sh'),
    const ActorFilterEntry('DioBandi', 'DB'),
    const ActorFilterEntry('Barelvi', 'Ba'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets sync* {
    for (final ActorFilterEntry actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          selected: _filters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _filters.add(actor.name);
              } else {
                _filters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Filters"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "\n  Maslaks",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Wrap(
                  children: actorWidgets.toList(),
                ),
                Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: Text(
                          "\n  Choice Filters",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: status,
                              activeColor: Color(0xFF4CAF50),
                              onChanged: (value) {
                                setState(() {
                                  status = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      leading: Text(
                        "Chair Facility",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: status2,
                              activeColor: Color(0xFF4CAF50),
                              onChanged: (value) {
                                setState(() {
                                  status2 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      leading: Text(
                        "Washroom",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: status3,
                              activeColor: Color(0xFF4CAF50),
                              onChanged: (value) {
                                setState(() {
                                  status3 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      leading: Text(
                        "Abolution",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Switch(
                              value: status4,
                              activeColor: Color(0xFF4CAF50),
                              onChanged: (value) {
                                setState(() {
                                  status4 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      leading: Text(
                        "Ground Floor",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      "\n  Distance (kms)\n",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                Container(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.greenAccent,
                      inactiveTrackColor: Colors.black12,
                      trackHeight: 4.0,
                      thumbColor: Colors.green,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 8.0),
                      overlayColor: Colors.purple.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 14.0),
                    ),
                    child: Slider.adaptive(
                      value: _currentSliderValue,
                      min: 0,
                      max: 50,
                      divisions: 50,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(
                          () {
                            _currentSliderValue = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
                // AutoSizeText(
                //   'Distance (kms)',
                //   maxFontSize: 30,
                //   textAlign: TextAlign.center,
                // ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {},
                      child: Text(
                        'Apply Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
                // Text('Look for: ${_filters.join(', ')}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
