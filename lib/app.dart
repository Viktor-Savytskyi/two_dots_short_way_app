import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwoDotsShortWayApp',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: AppBarTheme(
          backgroundColor:  Colors.lightBlue.shade700,
          foregroundColor:  Colors.white,
          centerTitle: false,
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        )
      ),
      home: const HomeScreen(),
    );
  }
}


