import 'package:flutter/material.dart';
import 'package:smart_flowmac/screens/login_screen.dart';
import 'package:smart_flowmac/screens/register_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/welcom_screen.dart';
import 'screens/navigation_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        WeclomScreen.id: (context) => WeclomScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        NavigationPages.id: (context) => NavigationPages(),
      },
    );
  }
}
