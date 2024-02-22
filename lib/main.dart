import 'package:delivery_app/screens/page_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/auth_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp( 
      initialRoute: '/',
      
      debugShowCheckedModeBanner: false,
      title: 'Delivery app',
      theme: appTheme(textTheme),
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const PageViewScreen(),
      },
    );
  }

  ThemeData appTheme(TextTheme textTheme) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF383434),
      brightness: Brightness.light,
      primaryColor: const Color(0xFFf0fc8c),
      textTheme: GoogleFonts.golosTextTextTheme(textTheme).copyWith(
        bodyMedium: GoogleFonts.golosText(
          textStyle: textTheme.bodyMedium,
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: GoogleFonts.golosText(
          textStyle: textTheme.bodyMedium,
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        headlineMedium: GoogleFonts.golosText(
          textStyle: textTheme.bodyMedium,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 24,
        ),
        titleLarge: GoogleFonts.golosText(
          textStyle: textTheme.bodyMedium,
          color: const Color(0xFF484444),
          fontWeight: FontWeight.w500,
          fontSize: 28,
        ),
      ),
    );
  }
  /// Color palette
  /// Color.fromARGB(255, 100, 99, 99) - text field(background)
  /// Color(0xFFf0fc8c) - yellow or light green(app bar background)
  /// Color(0xFF383434) - background color
  /// Color(0xFF484444) - black or dark gray(app bar text)
  
}
