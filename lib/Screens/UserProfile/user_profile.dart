import 'package:flutter/material.dart';
import 'package:healthcare/Screens/UserProfile/update_medical_records.dart';
import 'package:healthcare/Screens/UserProfile/update_profile.dart';
import 'medical_records.dart';
import 'package:firebase_database/firebase_database.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "User Profile",
      home: new UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class updatepenyakit {
  String key;
  String classification;
  String date;
  String symptoms;
  updatepenyakit(this.key, this.classification, this.date, this.symptoms);
  updatepenyakit.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        classification = snapshot.value["classification"],
        date = snapshot.value["date"],
        symptoms = snapshot.value["symptoms"];
  toJson() {
    return {
      "classification": classification,
      "date": date,
      "symptoms": symptoms,
    };
  }
}

class _Profile extends State<UserProfilePage> {
  List<updatepenyakit> items = List();
  updatepenyakit item;
  DatabaseReference itemRef;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Penyakit");
  String key;
  String classification;
  String date;
  String symptoms;

  var retrievedUrl = "";
  var retrievedName = "";
  var retrievedDob = "";
  var retrievedBt = "";
  int retrievedHeight;
  int retrievedWeight;
  void initState() {
    super.initState();
    item = updatepenyakit("", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('Penyakit');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);

    DatabaseReference referenceData1 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/name');
    referenceData1.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedName = dataSnapshot.value;
      });
    });

    DatabaseReference referenceData2 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/dob');
    referenceData2.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedDob = dataSnapshot.value;
      });
    });

    DatabaseReference referenceData3 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/bt');
    referenceData3.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedBt = dataSnapshot.value;
      });
    });

    DatabaseReference referenceData4 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/height');
    referenceData4.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedHeight = dataSnapshot.value;
      });
    });

    DatabaseReference referenceData5 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/weight');
    referenceData5.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedWeight = dataSnapshot.value;
      });
    });
    DatabaseReference referenceData6 =
        FirebaseDatabase.instance.reference().child('Biodata/Data1/url');
    referenceData6.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        retrievedUrl = dataSnapshot.value;
      });
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      items.add(updatepenyakit.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = updatepenyakit.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(top: 35.0, left: 16.0, right: 16.0),
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 10,
                        child: Text(
                          'Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 22.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        width: 107.0,
                        height: 107.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: (retrievedUrl != "")
                              ? NetworkImage(retrievedUrl)
                              : AssetImage('assets/icon/avatar_profpic.png'),
                          fit: BoxFit.fitHeight,
                        )),
                      ))
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        'User Information',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700),
                      )),
                    ],
                  ),
                  Container(
                    height: 15,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icon/Group25.png'),
                                      fit: BoxFit.fitHeight)),
                            )),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '   Full Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Text(
                            '$retrievedName',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icon/Group28.png'),
                                      fit: BoxFit.fitHeight)),
                            )),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '  Date of Birth',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '$retrievedDob',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icon/Group26.png'),
                                      fit: BoxFit.fitHeight)),
                            )),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '  Blood Type',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '$retrievedBt',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icon/Group29.png'),
                                      fit: BoxFit.fitHeight)),
                            )),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '  Body Height',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '$retrievedHeight',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/icon/Group27.png'),
                                      fit: BoxFit.fitHeight)),
                            )),
                        Expanded(
                          flex: 3,
                          child: Text(
                            '  Body Weight',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '$retrievedWeight',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ]),
                  Container(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 8,
                          child: Text(
                            'Medical Record',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 20.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: FlatButton(
                          height: 10,
                          child: Text(
                            'See More',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Lato',
                                fontSize: 15.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400),
                          ),
                          color: Color(0xFFFFFFFF),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicalRecords()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 115.0,
                    child: items.length == 0
                        ? Text("Update Medical Record")
                        : ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Center(
                                  child: Container(
                                    height: 115.0,
                                    width: 315.0,
                                    decoration: BoxDecoration(
                                      color: (items[index]
                                              .classification
                                              .contains("Mild"))
                                          ? Color(0xFF9DE2B9)
                                          : (items[index]
                                                  .classification
                                                  .contains("Moderate"))
                                              ? Color(0xFFFFEE9C)
                                              : Color(0xFFF47B94),
                                      border:
                                          Border.all(color: Colors.transparent),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 15, top: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              15 -
                                              10,
                                          child: Text(
                                            items[index].classification,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontFamily: 'Lato',
                                                fontSize: 15.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            items[index].symptoms,
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 20.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text(
                                            items[index].date,
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 10.0,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    height: 20,
                  ),
                  Container(
                    width: 315,
                    height: 40,
                    child: FlatButton(
                      textColor: Color(0xFF3B72FF),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateMedical()));
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFF3B72FF)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Update medical records',
                        style: (TextStyle(
                            fontFamily: 'Lato',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0)),
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Container(
                    width: 315,
                    height: 40,
                    child: FlatButton(
                      color: Color(0xFF3B72FF),
                      textColor: Color(0xFFFFFFFF),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UpdateProfile()));
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Update my profile',
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 15.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
