import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 90),
            Text.rich(TextSpan(
              text: 'Welcome',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: HexColor("#646AFA")),
            )),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text.rich(TextSpan(
                  text: 'Please login or signup to continue using our app.',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                ))
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
