import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool auto = false;
  bool manual = false;
  int groupValue = 0;
  final _fireSore = Firestore.instance;
  String currentOperation = 'Saved';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Controll'),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              onPressed: () {
                setState(() {
                  if (auto == true) {
                    currentOperation = 'auto';
                    _fireSore
                        .collection('control')
                        .add({'mode': currentOperation});
                  } else if (manual == true && groupValue == 1) {
                    currentOperation = 'off';
                    _fireSore
                        .collection('control')
                        .add({'mode': currentOperation});
                  } else if (manual == true && groupValue == 2) {
                    currentOperation = 'on';
                    _fireSore
                        .collection('control')
                        .add({'mode': currentOperation});
                  }
                });
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'auto',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: auto ? FontWeight.w400 : FontWeight.w100),
                  ),
                  SizedBox(
                    width: 220,
                  ),
                  Switch(
                    value: auto,
                    onChanged: (value) {
                      setState(() {
                        auto = value;
                        if (auto == true) {
                          manual = false;
                          groupValue = 0;
                        }
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
                child: Divider(),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'manual',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight:
                                manual ? FontWeight.w400 : FontWeight.w100),
                      ),
                      SizedBox(
                        width: 190,
                      ),
                      Switch(
                        value: manual,
                        onChanged: (value) {
                          setState(() {
                            manual = value;
                            if (manual == true) {
                              auto = false;
                              groupValue = 1;
                            } else if (manual == false) {
                              groupValue = 0;
                            }
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        groupValue: groupValue,
                        value: 1,
                        activeColor: manual ? Colors.blue : Colors.grey,
                        onChanged: (T) {
                          setState(() {
                            if (manual == true) {
                              groupValue = T;
                              print(groupValue);
                            } else {
                              groupValue = 0;
                            }
                          });
                        },
                      ),
                      Text(
                        'off',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight:
                                manual ? FontWeight.w300 : FontWeight.w100),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: groupValue,
                        value: 2,
                        activeColor: manual ? Colors.blue : Colors.grey,

                        // focusColor: Colors.red,
                        hoverColor: Colors.red,
                        onChanged: (T) {
                          setState(() {
                            if (manual == true) {
                              groupValue = T;
                              print(groupValue);
                            } else {
                              groupValue = 0;
                            }
                          });
                        },
                      ),
                      Text(
                        'on',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight:
                                manual ? FontWeight.w300 : FontWeight.w100),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
                child: Divider(),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Text(
                  'Operation Mode : $currentOperation',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
