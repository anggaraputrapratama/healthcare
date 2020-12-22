import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:healthcare/constant.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:healthcare/Screens/UserProfile/user_profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future signInAnonymus() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      return null;
    }
  }

  static Future<void> signOut() async {
    _auth.signOut();
  }
}

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  File _imageFile;
  String _url;
  final picker = ImagePicker();
  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Biodata");

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  Future uploadPic(BuildContext context) async {
    await Firebase.initializeApp();
    String fileName = basename(_imageFile.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    // TaskSnapshot taskSnapshot = await uploadTask;
    // taskSnapshot.ref.getDownloadURL().then((value) => print("Done: $value"));
    var url = await (await uploadTask).ref.getDownloadURL();
    _url = url;
    print("URL = $url");
  }

  String name;
  String dob;
  String gender;
  String region;
  String bt;
  int height;
  int weight;
  TextEditingController tgl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Container(
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/icon/back.png")),
                          shape: BoxShape.circle),
                      child: FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfilePage()),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Update my profile",
                      style: kHeadingTextStyle.copyWith(
                        color: kTitleTextColor,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                    )
                  ],
                ),
                SizedBox(height: 19),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Color(0xFF3B72FF),
                        child: ClipOval(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: (_imageFile != null)
                                ? Image.file(_imageFile, fit: BoxFit.fill)
                                : Image(
                                    image: AssetImage(
                                        "assets/icon/avatar_profpic.png"),
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icon/edit.png")),
                            ),
                            child: FlatButton(
                              onPressed: () async {
                                await AuthServices.signInAnonymus();
                                await pickImage();
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                        text: 'Tap to update',
                        style: kTitleTextstyle.copyWith(
                          color: kTitleTextColor,
                        )))
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/avatar1.png"),
                        ),
                        Text.rich(TextSpan(
                            text: 'Full name',
                            style: kSubTextStyle.copyWith(
                              color: kTitleTextColor,
                            ))),
                        Container(
                          height: 10,
                          width: 50,
                        ),
                        SizedBox(
                          width: 200,
                          height: 15,
                          child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                        )
                      ],
                    ),
                    SizedBox(height: 29),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/cake1.png"),
                        ),
                        Text.rich(TextSpan(
                            text: 'Date of Birth',
                            style: kSubTextStyle.copyWith(
                              color: kTitleTextColor,
                            ))),
                        Container(
                          height: 10,
                          width: 40,
                        ),
                        SizedBox(
                          width: 200,
                          height: 15,
                          child: InkWell(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 3, 5),
                                  maxTime: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                tgl.text =
                                    DateFormat('yyyy-MM-dd').format(date);
                                dob = tgl.text;
                                print('confirm $date');
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.id);
                            },
                            child: TextFormField(
                                controller: tgl,
                                enabled: false,
                                onChanged: (val) {
                                  setState(() {
                                    dob = val;
                                  });
                                },
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ))),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 29),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/blood1.png"),
                        ),
                        Text.rich(TextSpan(
                            text: 'Blood type',
                            style: kSubTextStyle.copyWith(
                              color: kTitleTextColor,
                            ))),
                        Container(
                          height: 10,
                          width: 50,
                        ),
                        SizedBox(
                          width: 200,
                          height: 15,
                          child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  bt = val;
                                });
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                        )
                      ],
                    ),
                    SizedBox(height: 29),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/height1.png"),
                        ),
                        Text.rich(TextSpan(
                            text: 'Body height',
                            style: kSubTextStyle.copyWith(
                              color: kTitleTextColor,
                            ))),
                        Container(
                          height: 10,
                          width: 30,
                        ),
                        SizedBox(
                          width: 200,
                          height: 15,
                          child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  height = int.parse(val);
                                });
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                        )
                      ],
                    ),
                    SizedBox(height: 29),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/weight1.png"),
                        ),
                        Text.rich(TextSpan(
                            text: 'Body weight',
                            style: kSubTextStyle.copyWith(
                              color: kTitleTextColor,
                            ))),
                        Container(
                          height: 10,
                          width: 25,
                        ),
                        SizedBox(
                          width: 200,
                          height: 15,
                          child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  weight = int.parse(val);
                                });
                              },
                              textAlign: TextAlign.right,
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ))),
                        )
                      ],
                    ),
                    SizedBox(height: 26),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage("assets/icon/exclamation1.png"),
                        ),
                        Container(
                          height: 10,
                          width: 10,
                        ),
                        Expanded(
                          child: Text.rich(TextSpan(
                              text:
                                  'Please update your body height and weight periodically for better real-time health information.',
                              style: TextStyle(
                                fontSize: 12,
                                color: kBodyTextColor,
                              ))),
                        ),
                      ],
                    ),
                  ],
                )
              ]),
            ),
          ),
          Container(
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Save changes',
                style: kSubTextStyle.copyWith(
                  color: Color(0xFFFFFFFF),
                ),
              ),
              color: Color(0xFF3B72FF),
              onPressed: () async {
                if (_imageFile != null) {
                  await uploadPic(context);
                }

                print('name = $name');
                if (name != null) {
                  database.child("Data1/name").set(name);
                }
                if (dob != null) {
                  database.child("Data1/dob").set(dob);
                }
                if (bt != null) {
                  database.child("Data1/bt").set(bt);
                }
                if (height != null) {
                  database.child("Data1/height").set(height);
                }
                if (weight != null) {
                  database.child("Data1/weight").set(weight);
                }
                if (_url != null) {
                  database.child("Data1/url").set(_url);
                }

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => UserProfilePage()));
              },
            ),
            padding: EdgeInsets.all(50),
          )
        ],
      ),
    );
  }
}
