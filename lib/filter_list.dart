// import 'package:filter_list/filter_list.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class FilterList extends StatefulWidget {
//   FilterList({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _FilterListState createState() => _FilterListState();
// }
//
// class _FilterListState extends State<FilterList> {
//   List<User> selectedUserList = [];
//
//   void _openFilterDialog() async {
//     await FilterListDialog.display(context,
//         listData: userList,
//         selectedListData: selectedUserList,
//         label: (item) {
//           return item.name;
//         },
//         validateSelectedItem: (list, val) {
//           return list.contains(val);
//         },
//         onItemSearch: (list, text) {
//           /// When text change in search text field then return list containing that text value
//           ///
//           ///Check if list has value which matchs to text
//           if (list.any((element) =>
//               element.name.toLowerCase().contains(text.toLowerCase()))) {
//             /// return list which contains matches
//
//           }
//           return list
//               .where((element) =>
//                   element.name.toLowerCase().contains(text.toLowerCase()))
//               .toList();
//         },
//         width: 480,
//         height: 480,
//         borderRadius: 20,
//         headlineText: "Select Count",
//         searchFieldHintText: "Search Here",
//         onApplyButtonClick: (list) {
//           if (list != null) {
//             setState(() {
//               selectedUserList = List.from(list);
//             });
//             Navigator.pop(context);
//           }
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           TextButton(
//             onPressed: () async {
//               var list = await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FilterPage(
//                     allTextList: userList,
//                     selectedUserList: selectedUserList,
//                   ),
//                 ),
//               );
//               if (list != null) {
//                 setState(() {
//                   selectedUserList = List.from(list);
//                 });
//               }
//             },
//             child: Text(
//               "Filter Page",
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//             ),
//           ),
//           TextButton(
//             onPressed: _openFilterDialog,
//             child: Text(
//               "Filter Dialog",
//               style: TextStyle(color: Colors.white),
//             ),
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           selectedUserList == null || selectedUserList.length == 0
//               ? Expanded(
//                   child: Center(
//                     child: Text('No text selected'),
//                   ),
//                 )
//               : Expanded(
//                   child: ListView.separated(
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           title: Text(selectedUserList[index].name),
//                         );
//                       },
//                       separatorBuilder: (context, index) => Divider(),
//                       itemCount: selectedUserList.length),
//                 ),
//         ],
//       ),
//     );
//   }
// }
//
// class FilterPage extends StatelessWidget {
//   const FilterPage({Key key, this.allTextList, this.selectedUserList})
//       : super(key: key);
//   final List<User> allTextList;
//   final List<User> selectedUserList;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Filter list Page"),
//       ),
//       body: Expanded(
//         child: FilterListWidget(
//           width: 100,
//           listData: userList,
//           selectedListData: selectedUserList,
//           hideheaderText: true,
//           onApplyButtonClick: (list) {
//             Navigator.pop(context, list);
//           },
//           label: (item) {
//             /// Used to print text on chip
//             return item.name;
//           },
//           validateSelectedItem: (list, val) {
//             ///  identify if item is selected or not
//             return list.contains(val);
//           },
//           onItemSearch: (list, text) {
//             /// When text change in search text field then return list containing that text value
//             ///
//             ///Check if list has value which matchs to text
//             if (list.any((element) =>
//                 element.name.toLowerCase().contains(text.toLowerCase()))) {
//               /// return list which contains matches
//
//             }
//             return list
//                 .where((element) =>
//                     element.name.toLowerCase().contains(text.toLowerCase()))
//                 .toList();
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class User {
//   final String name;
//   final String avatar;
//   User({this.name, this.avatar});
// }
//
// /// Creating a global list for example purpose.
// /// Generally it should be within data class or whereever you want
// List<User> userList = [
//   User(name: "Jon", avatar: "asd"),
//   User(name: "Lindsey ", avatar: "asd"),
//   User(name: "Valarie ", avatar: "asd"),
//   User(name: "Elyse ", avatar: "asd"),
//   User(name: "Ethel ", avatar: "asd"),
//   User(name: "Emelyan ", avatar: "asd"),
//   User(name: "Catherine ", avatar: "asd"),
//   User(name: "Stepanida  ", avatar: "asd"),
//   User(name: "Carolina ", avatar: "asd"),
//   User(name: "Nail  ", avatar: "asd"),
// ];
