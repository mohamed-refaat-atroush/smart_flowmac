import 'package:flutter/material.dart';
import 'package:smart_flowmac/components/rounded_button.dart';
import 'package:smart_flowmac/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'navigation_pages.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // controller.reverse();
        controller.repeat();
      }
      /*else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }*/
    });

    controller.addListener(() {
      setState(() {});
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RotationTransition(
                  turns: animation,
                  child: CircleAvatar(
                    child: Hero(
                        tag: 'logo', child: Image.asset('images/logo2.jpg')),
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, NavigationPages.id);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
