import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_flowmac/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:smart_flowmac/screens/login_screen.dart';
import 'package:smart_flowmac/screens/register_screen.dart';

class WeclomScreen extends StatefulWidget {
  static const String id = 'welcom_screen';
  @override
  _WeclomScreenState createState() => _WeclomScreenState();
}

class _WeclomScreenState extends State<WeclomScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child:
                      Hero(tag: 'logo', child: Image.asset('images/logo2.jpg')),
                  radius: 40,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 220,
                  child: TextLiquidFill(
                    text: 'SmartFlowmac',
                    boxBackgroundColor: Colors.white,
                    waveColor: Colors.blueAccent,
                    textStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    boxHeight: 50,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.id);
              },
            )
          ],
        ),
      ),
    ));
  }
}
