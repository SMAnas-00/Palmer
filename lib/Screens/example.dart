// import 'package:flutter/material.dart';

// class FlightBookingScreen extends StatefulWidget {
//   @override
//   _FlightBookingScreenState createState() => _FlightBookingScreenState();
// }

// class _FlightBookingScreenState extends State<FlightBookingScreen> {
//   int _selectedTabIndex = 0;
//   String _fromLocation = '';
//   String _toLocation = '';
//   String _selectedDepartureDate = '';
//   String _selectedReturnDate = '';

//   final List<String> _locations = [
//     'New York',
//     'London',
//     'Paris',
//     'Tokyo',
//     'Beijing',
//     'Sydney'
//   ];

//   final List<String> _passengerCount = [
//     '1 Adult',
//     '2 Adults',
//     '3 Adults',
//     '4 Adults',
//     '5 Adults',
//     '6 Adults'
//   ];

//   final List<String> _classType = ['Economy', 'Business', 'First Class'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flight Booking'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             _buildTabBar(),
//             SizedBox(height: 16.0),
//             Expanded(child: _buildTabView())
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabBar() {
//     return TabBar(
//       onTap: (int index) {
//         setState(() {
//           _selectedTabIndex = index;
//         });
//       },
//       tabs: <Widget>[
//         Tab(text: 'One Way'),
//         Tab(text: 'Round Trip'),
//       ],
//       controller: TabController(
//         vsync: AnimatedListState(),
//         length: 2,
//         initialIndex: _selectedTabIndex,
//       ),
//     );
//   }

//   Widget _buildTabView() {
//     if (_selectedTabIndex == 0) {
//       return _buildOneWayTabView();
//     } else {
//       return _buildRoundTripTabView();
//     }
//   }

//   Widget _buildOneWayTabView() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text('From', style: TextStyle(fontSize: 18.0)),
//         DropdownButton<String>(
//           value: _fromLocation,
//           onChanged: (String newValue) {
//             setState(() {
//               _fromLocation = newValue;
//             });
//           },
//           items: _locations
//               .map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 16.0),
//         Text('To', style: TextStyle(fontSize: 18.0)),
//         DropdownButton<String>(
//           value: _toLocation,
//           onChanged: (String newValue) {
//             setState(() {
//               _toLocation = newValue;
//             });
//           },
//           items:
//               _locations.map<DropdownMenuItem<String>>((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 16.0),
//         Text('Departure Date', style: TextStyle(fontSize: 18.0)),
//         InkWell(
//           onTap: () => _selectDate(context),
//           child: Container(
//             padding: EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: <Widget>[
//                 Icon(Icons.calendar_today),
//                 SizedBox(width: 16.0),
//                 Text(_selectedDepartureDate
//                 )])))])}