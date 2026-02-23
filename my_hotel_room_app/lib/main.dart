import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_hotel_room_app/hom_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Room',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff4988C4)),
        textTheme: GoogleFonts.kanitTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xff4988C4),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomPage(),
    );
  }
}
