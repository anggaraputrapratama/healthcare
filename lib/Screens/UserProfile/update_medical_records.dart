import 'package:flutter/material.dart';
import 'package:healthcare/constant.dart';
import 'package:healthcare/Screens/UserProfile/user_profile.dart';
import 'package:firebase_database/firebase_database.dart';

class UpdateMedical extends StatefulWidget {
  @override
  _UpdateMedicalState createState() => _UpdateMedicalState();
}

class updatepenyakit {
  String key;
  String classification;
  String date;
  String doctor;
  String hospital;
  String status;
  String symptoms;
  updatepenyakit(this.key, this.classification, this.date, this.doctor,
      this.hospital, this.status, this.symptoms);
  updatepenyakit.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        classification = snapshot.value["classification"],
        date = snapshot.value["date"],
        doctor = snapshot.value["doctor"],
        hospital = snapshot.value["hospital"],
        status = snapshot.value["status"],
        symptoms = snapshot.value["symptoms"];
  toJson() {
    return {
      "classification": classification,
      "date": date,
      "doctor": doctor,
      "hospital": hospital,
      "status": status,
      "symptoms": symptoms,
    };
  }
}

class _UpdateMedicalState extends State<UpdateMedical> {
  List<updatepenyakit> items = List();
  updatepenyakit item;
  DatabaseReference itemRef;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _classVal;
  String _statusVal;
  List _className = ['Mild', 'Moderate', 'Severe'];
  List _statusName = [
    'Cured',
    'Ongoing',
  ];

  final DatabaseReference database =
      FirebaseDatabase.instance.reference().child("Penyakit");

  @override
  void initState() {
    super.initState();
    item = updatepenyakit("", "", "", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    itemRef = database.reference().child('Penyakit');
    itemRef.onChildAdded.listen(_onEntryAdded);
    itemRef.onChildChanged.listen(_onEntryChanged);
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

  void handleSubmit() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      itemRef.push().set(item.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    children: [
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
                                      builder: (context) => UserProfile()),
                                );
                              },
                            ),
                          ),
                          Text(
                            "Update medical records",
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
                      SizedBox(height: 44),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Illness Classification",
                            style: kTitleTextstyle.copyWith(
                              color: kTitleTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(TextSpan(
                                text: 'Classification',
                                style: kSubTextStyle.copyWith(
                                  color: kTitleTextColor,
                                ))),
                            Container(
                              child: DropdownButton(
                                hint: Text('Please choose..'),
                                value: _classVal,
                                onChanged: (val) => item.classification = val,
                                items: _className.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Details",
                            style: kTitleTextstyle.copyWith(
                              color: kTitleTextColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'Main symptoms',
                                  style: kSubTextStyle.copyWith(
                                    color: kTitleTextColor,
                                  ))),
                              Container(
                                height: 10,
                                width: 50,
                              ),
                              SizedBox(
                                width: 180,
                                height: 15,
                                child: TextField(
                                    onChanged: (val) => item.symptoms = val,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'Date of illness',
                                  style: kSubTextStyle.copyWith(
                                    color: kTitleTextColor,
                                  ))),
                              Container(
                                height: 10,
                                width: 50,
                              ),
                              SizedBox(
                                width: 180,
                                height: 15,
                                child: TextField(
                                    onChanged: (val) => item.date = val,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'Hospital',
                                  style: kSubTextStyle.copyWith(
                                    color: kTitleTextColor,
                                  ))),
                              Container(
                                height: 10,
                                width: 50,
                              ),
                              SizedBox(
                                width: 180,
                                height: 15,
                                child: TextField(
                                    onChanged: (val) => item.hospital = val,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'Doctor',
                                  style: kSubTextStyle.copyWith(
                                    color: kTitleTextColor,
                                  ))),
                              Container(
                                height: 10,
                                width: 50,
                              ),
                              SizedBox(
                                width: 180,
                                height: 15,
                                child: TextField(
                                    onChanged: (val) => item.doctor = val,
                                    textAlign: TextAlign.right,
                                    decoration: InputDecoration(
                                        labelStyle: TextStyle(
                                      fontFamily: 'Lato',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(TextSpan(
                                  text: 'Status',
                                  style: kSubTextStyle.copyWith(
                                    color: kTitleTextColor,
                                  ))),
                              Container(
                                height: 10,
                                width: 50,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  child: DropdownButton(
                                    hint: Text('Please choose..'),
                                    value: _statusVal,
                                    onChanged: (val) => item.status = val,
                                    items: _statusName.map((value) {
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]),
                      ),
                    ],
                  ),
                )),
          ),
          Container(
            width: double.infinity,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Input medical record',
                style: kSubTextStyle.copyWith(
                  color: Color(0xFFFFFFFF),
                ),
              ),
              color: Color(0xFF3B72FF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfile()),
                );
                handleSubmit();
              },
            ),
            padding: EdgeInsets.all(50),
          )
        ],
      ),
    );
  }
}
