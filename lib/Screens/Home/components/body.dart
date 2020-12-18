import 'package:flutter/material.dart';
import 'package:healthcare/Screens/Home/Heartbeat/heartbeat_screen.dart';
import 'package:healthcare/Screens/Home/components/background.dart';
import 'package:healthcare/Screens/Weight/weight_screen.dart';
import 'package:healthcare/components/button_fitur.dart';
import 'package:healthcare/components/rounded_button.dart';
import 'package:healthcare/constant.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning,",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: kPrimaryLightColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Anggara",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: kPrimaryLightColor),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.1),
              ButtonFitur(
                text: "Heartbeat",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Heartbeat();
                      },
                    ),
                  );
                },
              ),
              ButtonFitur(
                text: "Weight",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Weight();
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
