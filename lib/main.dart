import 'package:flutter/material.dart';
import 'screens/attendance_screen.dart'; // Import AttendanceScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Attendance',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: AttendanceScreen(), // Set AttendanceScreen as the initial screen
    );
  }
}
