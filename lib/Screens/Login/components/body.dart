import 'package:flutter/material.dart';
import 'package:healthcare/Screens/Home/home_screen.dart';
import 'package:healthcare/components/or_divider.dart';
import 'package:healthcare/components/rounded_button.dart';
import 'package:healthcare/components/rounded_input_field.dart';
import 'package:healthcare/components/rounded_password_field.dart';
import 'package:healthcare/components/social_icon.dart';
import 'package:healthcare/constant.dart';
import 'package:flutter_svg/svg.dart';

class BodyLogin extends StatelessWidget {
  const BodyLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Login ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: kPrimaryColor),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Please login to continue using our app.",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/images/Logo Health Tracker.svg",
                height: size.height * 0.25,
              ),
              SizedBox(height: size.height * 0.04),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "Login",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomeScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.01),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocalIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocalIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
