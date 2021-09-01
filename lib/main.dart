import 'package:current_cases_app/providers/case_provider.dart';
import 'package:current_cases_app/providers/hospital_provider.dart';
import 'package:current_cases_app/providers/status_provider.dart';
import 'package:current_cases_app/providers/vaccine_provider.dart';
import 'package:current_cases_app/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VaccineProvider()),
        ChangeNotifierProvider(create: (_) => CaseProvider()),
        ChangeNotifierProvider(create: (_) => HospitalProvider()),
        ChangeNotifierProvider(create: (_) => StatusProvider()),
        ChangeNotifierProvider(create: (_) => VaccineGroupProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Futura',
      ),
      home: BottomNavScreen(),
    );
  }
}
