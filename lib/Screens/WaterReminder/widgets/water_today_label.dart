import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WaterTodayLabel extends StatefulWidget {
  @override
  _WaterTodayLabelState createState() => _WaterTodayLabelState();
}

class _WaterTodayLabelState extends State<WaterTodayLabel> {
  @override
  Widget build(BuildContext context) {
    final todayDate = new DateTime.now();
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat("EEEE").format(todayDate),
                style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                  DateFormat("d MMMM yyyy").format(todayDate),
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
