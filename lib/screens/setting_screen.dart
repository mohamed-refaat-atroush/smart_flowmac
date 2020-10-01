import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _fireStore = Firestore.instance;
  int defaultValue = 30;
  String kPressure = 'Saved';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onPressed: () {
                setState(() {
                  kPressure = defaultValue.toString();
                });
                setState(() {
                  kPressure = defaultValue.toString();
                });
                try {
                  setState(() async {
                    await _fireStore
                        .collection('setting')
                        .add({'pressure': defaultValue});
                  });
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Insert Pressure !',
                style: TextStyle(fontSize: 20, color: Colors.redAccent),
              ),
              SizedBox(
                width: double.infinity,
                child: Divider(),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 40.0),
                    child: Counter(
                      initialValue: defaultValue,
                      minValue: 10,
                      maxValue: 100,
                      step: 5,
                      decimalPlaces: 1,
                      buttonSize: 30,
                      textStyle: TextStyle(fontSize: 40),
                      onChanged: (value) {
                        // get the latest value from here
                        setState(() {
                          defaultValue = value;
                        });
                      },
                    ),
                  ),
                  Text(' pressure is $defaultValue'),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Divider(),
              ),
              Text(
                'Current Pressure : $kPressure',
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
