// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Nav extends StatefulWidget {
//   @override
//   _NavState createState() => _NavState();
// }

// class _NavState extends State<Nav> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = <Widget>[
//     Text('weather'),
//     Text('Time Table'),
//     Text('Details'),
//     Text('contact'),
//     Text('other'),
//   ];
//   void _onItemTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bottom Nav Bar'),
//       ),
//       body: Text('Home'),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             title: Text('weather'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.table_view),
//             title: Text('Time Table'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             title: Text('Details'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             title: Text('contact'),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             title: Text('other'),
//           ),
//         ],
//       ),
//     );
//   }
// }
