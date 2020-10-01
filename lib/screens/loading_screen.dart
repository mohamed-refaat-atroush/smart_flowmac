import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:smart_flowmac/screens/welcom_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutExpo);
    controller.forward();
    controller.addListener(() {
      setState(() {
        goNext();
      });
    });
  }

  void goNext() {
    if (animation.value * 100 == 100) {
      setState(() {
        Navigator.pushNamed(context, WeclomScreen.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircleAvatar(
            child: Hero(tag: 'logo', child: Image.asset('images/logo2.jpg')),
            radius: (animation.value * 100),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
