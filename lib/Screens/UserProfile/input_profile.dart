import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:healthcare/Screens/UserProfile/user_profile.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class InputProfile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Biodata");

  String name = "";
  String dob = "";
  String gender = "";
  String region = "";
  String bt = "";
  int height;
  int weight;
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController tgl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Form(
            key: _key,
            child: Column(
              children: <Widget>[
                ClipPath(
                  clipper: MyClipper(),
                  child: Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width -
                                150 -
                                2 * 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Let's Us Know You!",
                                  style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Please fill in your biodata and let us know who you are.",
                                  style: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 13,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    //image: NetworkImage(imagePath)),
                                    image: AssetImage(
                                        "assets/icon/ic_avatar.png")),
                                shape: BoxShape.circle),
                          )
                        ],
                      ),
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFF3B72FF),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 3, 5),
                          maxTime: DateTime(2100, 6, 7), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        tgl.text = DateFormat('yyyy-MM-dd').format(date);
                        print('confirm $date');
                      }, currentTime: DateTime.now(), locale: LocaleType.id);
                    },
                    child: TextFormField(
                        controller: tgl,
                        enabled: false,
                        validator: (String val) =>
                            (val.length == 0) ? "Form cannot be empty" : null,
                        onChanged: (val) {
                          setState(() {
                            dob = val;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: "Date of Birth ",
                            labelStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          gender = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Gender",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          region = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Region",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          bt = val;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Blood Type",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          height = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Height",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32, right: 32),
                  child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (String val) =>
                          (val.length == 0) ? "Form cannot be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          weight = int.parse(val);
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Weight",
                          labelStyle: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ))),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    //padding: const EdgeInsets.only(left: 32, right: 32),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 2 * 32,
                      child: FlatButton(
                          color: Color(0xFF3B72FF),
                          textColor: Colors.white,
                          splashColor: Colors.white,
                          onPressed: () {
                            validation();
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                fontStyle: FontStyle.normal),
                          )),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validation() {
    if (_key.currentState.validate()) {
      database.child("Data1/name").set(name);
      database.child("Data1/dob").set(dob);
      database.child("Data1/gender").set(gender);
      database.child("Data1/region").set(region);
      database.child("Data1/bt").set(bt);
      database.child("Data1/height").set(height);
      database.child("Data1/weight").set(weight);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => UserProfilePage()));
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
