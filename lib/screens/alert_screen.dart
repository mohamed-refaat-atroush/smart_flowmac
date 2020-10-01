import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Usage'),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[MessagesStream()],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection("alert").orderBy("timestamp").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final messageText = message.data['error'];

          //final messageSender = message.data['sender'];

          //final currentUser = loggedInUser.email;
          var now = new DateTime.now();
          var day = now.day;
          var month = now.month;
          var year = now.year;
          String date = '$day/ $month / $year ';

          final messageBubble = MessageBubble(text: messageText, timeNow: date);

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.timeNow});

  final String text;
  final timeNow;
  // final timeStamp = Timestamp.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            elevation: 5.0,
            color: text == 'motor' ? Colors.amberAccent : Colors.redAccent,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Text(
                      text == 'motor'
                          ? 'there is a problem in your motor '
                              'please check your motor'
                          : 'you may have a leak at home,'
                              'you should check the house as soon as possible',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        letterSpacing: 2,
                        fontWeight:
                            text == 'motor' ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$timeNow',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
