import 'package:flutter/material.dart';
import 'package:mini_e_commerce/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(centerTitle: true),
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber)),
      home: const HomePage(),
    );
  }
}
