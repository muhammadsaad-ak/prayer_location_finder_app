import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  List<bool> _values = [false, false, false, false];
  double _currentSliderValue = 5;
  final List<Filters> cast2 = <Filters>[
    const Filters("Maslaq", "M"),
    const Filters("Chair Facility", "CF"),
    const Filters("Ground Floor", "GF"),
    const Filters("Ablution", "A"),
    const Filters("Washroom", "W"),
  ];
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
    final int count = 4;
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
                    for (int i = 0; i < count; i++)
                      ListTile(
                        title: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: _values[i],
                                activeColor: Color(0xFF4CAF50),
                                onChanged: i == count
                                    ? null
                                    : (bool value) {
                                        setState(() {
                                          _values[i] = value;
                                        });
                                      },
                              ),
                            ),
                          ],
                        ),
                        leading: Text(
                          'Switch ${i + 1}',
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color:
                                  i == count ? Colors.black38 : Colors.black),
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
