import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HeartBeat extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                child: Text('Read Data'),
                color: Colors.blue,
                onPressed: () {
                  readData();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void readData() {
    databaseReference.child('HeartRate').once().then((DataSnapshot snapshot) {
      new Text('Heart Rate: ${snapshot.value}');
      print('Heart Rate : ${snapshot.value}');
    });
  }
}
