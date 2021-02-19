import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'filter_list.dart';
import 'map.dart';
import 'package:prayer_location_finder_app/registration_form/mosque_reg_form.dart';

class MosqueList extends StatefulWidget {
  @override
  _MosqueListState createState() => _MosqueListState();
}

class _MosqueListState extends State<MosqueList> {
  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  String _value = 'Filters';
  var title = 'Mosques List';
  double _currentSliderValue = 5;
  Choice _selectedChoice = choices[0];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        // resizeToAvoidBottomPadding: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(title),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 7.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyCustomForm();
                      },
                    ),
                  );
                },
                child: Icon(
                  FontAwesomeIcons.list,
                  size: 20.0,
                ),
              ),
            ),
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.skip(2).map((Choice choice) {
                  return PopupMenuItem<Choice>(
                      value: choice, child: Text(choice.title));
                }).toList();
              },
            ),
            // ChoiceCard(choice: _selectedChoice),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.greenAccent,
                    inactiveTrackColor: Colors.black12,
                    trackHeight: 4.0,
                    thumbColor: Colors.green,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayColor: Colors.purple.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
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
              AutoSizeText(
                'Distance (kms)',
                maxFontSize: 30,
                textAlign: TextAlign.center,
              ),
              Expanded(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  itemBuilder: (context, position) => ListTile(
                    onTap: () {
                      return Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Map();
                          },
                        ),
                      );
                    },
                    title: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 6.0),
                                  child: Text(
                                    'Mosque Name',
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 6.0, 12.0, 12.0),
                                  child: Text(
                                    'Filters',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Distance",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.star_border,
                                      size: 35.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 2.0,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  // itemCount: sendersList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class ChoiceCard extends StatelessWidget {
//   final Choice choice;
//
//   const ChoiceCard({Key key, this.choice}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var textStyle = Theme.of(context).textTheme.display1;
//     return Padding(
//       padding: const EdgeInsets.all(0.0),
//       child: Card(
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 choice.icon,
//                 size: 128.0,
//               ),
//               Text(choice.title, style: textStyle)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Maslaq', icon: Icons.group),
  const Choice(title: 'Chaie Facility', icon: FontAwesomeIcons.chair),
  const Choice(title: 'Ground Floor', icon: Icons.height),
  const Choice(title: 'Ablution', icon: FontAwesomeIcons.water),
  const Choice(title: 'Washroom', icon: Icons.room),
  const Choice(title: 'Public/Private', icon: Icons.public),
];
