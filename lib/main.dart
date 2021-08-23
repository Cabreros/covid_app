import 'package:current_cases_app/screens/bottom_nav_screen.dart';
import 'package:current_cases_app/services/vaccine_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
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
        home: BlocProvider<VaccineCubit>(
            create: (context) => VaccineCubit()..getVaccineData(),
            child: BottomNavScreen()));
  }
}
