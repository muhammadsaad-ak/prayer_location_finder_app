import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'filter_list.dart';
import 'package:filter_list/filter_list.dart';
import 'map.dart';
import 'package:prayer_location_finder_app/registration_form/mosque_reg_form.dart';
import 'widgets/filter_dialog.dart';
import 'widgets/choices.dart';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

class MosqueList extends StatefulWidget {
  MosqueList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MosqueListState createState() => _MosqueListState();
}

class _MosqueListState extends State<MosqueList> {
  List<User> selectedUserList = [];

  // void _openFilterDialog() async {
  //   await FilterListDialog.display(context,
  //       closeIconColor: Colors.green,
  //       applyButonTextBackgroundColor: Colors.green,
  //       hideSearchField: true,
  //       listData: userList,
  //       selectedListData: selectedUserList,
  //       label: (item) {
  //         return item.name;
  //       },
  //       validateSelectedItem: (list, val) {
  //         return list.contains(val);
  //       },
  //       onItemSearch: (list, text) {
  //         /// When text change in search text field then return list containing that text value
  //         ///
  //         ///Check if list has value which matchs to text
  //         if (list.any((element) =>
  //             element.name.toLowerCase().contains(text.toLowerCase()))) {
  //           /// return list which contains matches
  //
  //         }
  //         return list
  //             .where((element) =>
  //                 element.name.toLowerCase().contains(text.toLowerCase()))
  //             .toList();
  //       },
  //       width: 5000,
  //       height: 500,
  //       borderRadius: 20,
  //       headlineText: "Mosque Filters",
  //       searchFieldHintText: "Search Here",
  //       onApplyButtonClick: (list) {
  //         if (list != null) {
  //           setState(() {
  //             selectedUserList = List.from(list);
  //           });
  //           Navigator.pop(context);
  //         }
  //       });
  // }

  String _value = 'Filters';
  var title = 'Mosques List';
  double _currentSliderValue = 5;
  // Choice _selectedChoice = choices[0];

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
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CastFilter();
                    },
                  ),
                );
              },
              child: Text(
                "Filter Dialog",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            // PopupMenuButton<Choice>(
            //   onSelected: _select,
            //   itemBuilder: (BuildContext context) {
            //     return choices.skip(2).map((Choice choice) {
            //       return PopupMenuItem<Choice>(
            //           value: choice, child: Text(choice.title));
            //     }).toList();
            //   },
            // ),
            // ChoiceCard(choice: _selectedChoice),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
class User {
  final String name;
  final String avatar;
  User({this.name, this.avatar});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or whereever you want
List<User> userList = [
  User(name: "Maslaq", avatar: "asd"),
  User(name: "Chair Facility", avatar: "asd"),
  User(name: "Ground Floor", avatar: "asd"),
  User(name: "Ablution", avatar: "asd"),
  User(name: "Washroom", avatar: "asd"),
  User(name: "Public/Private", avatar: "asd"),
];

// class Choice {
//   final String title;
//   final IconData icon;
//
//   const Choice({this.title, this.icon});
// }
//
// List<Choice> choices = [
//   Choice(title: 'Maslaq', icon: Icons.group),
//   Choice(title: 'Chaie Facility', icon: FontAwesomeIcons.chair),
//   Choice(title: 'Ground Floor', icon: Icons.height),
//   Choice(title: 'Ablution', icon: FontAwesomeIcons.water),
//   Choice(title: 'Washroom', icon: Icons.room),
//   Choice(title: 'Public/Private', icon: Icons.public),
// ];
