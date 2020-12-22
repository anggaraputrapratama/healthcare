import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Weight extends StatefulWidget {
  @override
  _WeightState createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  void initState() {
    super.initState();

    DatabaseReference refData =
        FirebaseDatabase.instance.reference().child("Biodata/Data1/weight");
    refData.once().then((DataSnapshot dataSnapShot) {
      setState(() {
        retrievedBerat = dataSnapShot.value;
      });
    });
    DatabaseReference refDataa =
        FirebaseDatabase.instance.reference().child("Biodata/Data1/height");
    refDataa.once().then((DataSnapshot dataSnapShot) {
      setState(() {
        retrievedTinggi = dataSnapShot.value;
      });
    });
  }

  var retrievedJudull = "";
  var retrievedpenuliss = "";
  String penuliss = "";
  var retrievedlinkk = "";
  String linkk = "";
  var retrievedBerat = 0;
  int vbb = 0;
  var retrievedTinggi = 0;
  int vtb = 0;
  var retrievedBreakfast = "";
  String breakfast = "";
  var retrievedLunch = "";
  String lunch = "";
  var retrievedDinner = "";
  String dinner = "";

  hasilbmi() {
    double bmi =
        retrievedBerat / ((retrievedTinggi / 100) * (retrievedTinggi / 100));
    String status = '';
    if (bmi <= 18.5) {
      status = 'Kurus';
      return status;
    } else if (bmi > 18.5 && bmi <= 24.9) {
      status = 'Ideal';
      return status;
    } else if (bmi > 24.9 && bmi <= 29.9) {
      status = 'Gemuk';
      return status;
    } else {
      status = 'Obesitas';
      return status;
    }
  }

  menumakan() {
    if (hasilbmi() == 'Kurus') {
      DatabaseReference refBreakfast = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/1/breakfast");
      refBreakfast.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedBreakfast = dataSnapShot.value;
        });
      });
      DatabaseReference refLunch = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/1/lunch");
      refLunch.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedLunch = dataSnapShot.value;
        });
      });
      DatabaseReference refDinner = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/1/dinner");
      refDinner.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedDinner = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Ideal') {
      DatabaseReference refBreakfast = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/2/breakfast");
      refBreakfast.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedBreakfast = dataSnapShot.value;
        });
      });
      DatabaseReference refLunch = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/2/lunch");
      refLunch.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedLunch = dataSnapShot.value;
        });
      });
      DatabaseReference refDinner = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/2/dinner");
      refDinner.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedDinner = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Gemuk') {
      DatabaseReference refBreakfast = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/3/breakfast");
      refBreakfast.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedBreakfast = dataSnapShot.value;
        });
      });
      DatabaseReference refLunch = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/3/lunch");
      refLunch.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedLunch = dataSnapShot.value;
        });
      });
      DatabaseReference refDinner = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/3/dinner");
      refDinner.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedDinner = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Obesitas') {
      DatabaseReference refBreakfast = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/4/breakfast");
      refBreakfast.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedBreakfast = dataSnapShot.value;
        });
      });
      DatabaseReference refLunch = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/4/lunch");
      refLunch.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedLunch = dataSnapShot.value;
        });
      });
      DatabaseReference refDinner = FirebaseDatabase.instance
          .reference()
          .child("rekomendasimakanan/4/dinner");
      refDinner.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedDinner = dataSnapShot.value;
        });
      });
    }
  }

  infokesehatan() {
    if (hasilbmi() == 'Kurus') {
      DatabaseReference refJudul = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/1/Judul");
      refJudul.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedJudull = dataSnapShot.value;
        });
      });
      DatabaseReference refPenulis = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/1/penulis");
      refPenulis.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedpenuliss = dataSnapShot.value;
        });
      });
      DatabaseReference refLink = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/1/link");
      refLink.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedlinkk = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Ideal') {
      DatabaseReference refJudul = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/2/Judul");
      refJudul.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedJudull = dataSnapShot.value;
        });
      });
      DatabaseReference refPenulis = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/2/penulis");
      refPenulis.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedpenuliss = dataSnapShot.value;
        });
      });
      DatabaseReference refLink = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/2/link");
      refLink.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedlinkk = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Gemuk') {
      DatabaseReference refJudul = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/3/Judul");
      refJudul.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedJudull = dataSnapShot.value;
        });
      });
      DatabaseReference refPenulis = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/3/penulis");
      refPenulis.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedpenuliss = dataSnapShot.value;
        });
      });
      DatabaseReference refLink = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/3/link");
      refLink.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedlinkk = dataSnapShot.value;
        });
      });
    } else if (hasilbmi() == 'Obesitas') {
      DatabaseReference refJudul = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/4/Judul");
      refJudul.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedJudull = dataSnapShot.value;
        });
      });
      DatabaseReference refPenulis = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/4/penulis");
      refPenulis.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedpenuliss = dataSnapShot.value;
        });
      });
      DatabaseReference refLink = FirebaseDatabase.instance
          .reference()
          .child("informasikesehatan/4/link");
      refLink.once().then((DataSnapshot dataSnapShot) {
        setState(() {
          retrievedlinkk = dataSnapShot.value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    menumakan();
    infokesehatan();
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
      child: new Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 45.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(
                "Body Weight",
                style: GoogleFonts.merriweather(fontSize: 30.0),
              ),
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: new Text(
                      '$retrievedBerat',
                      style: GoogleFonts.lato(
                          fontSize: 55.0, fontWeight: FontWeight.w600),
                    ),
                  ),
                  new Text(
                    "Kg",
                    style: GoogleFonts.lato(
                        fontSize: 20.0, fontWeight: FontWeight.w600),
                  ),
                  new Container(
                    child: new IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          DatabaseReference refData = FirebaseDatabase.instance
                              .reference()
                              .child("Biodata/Data1/weight");
                          refData.once().then((DataSnapshot dataSnapShot) {
                            setState(() {
                              retrievedBerat = dataSnapShot.value;
                            });
                          });
                          DatabaseReference refDataa = FirebaseDatabase.instance
                              .reference()
                              .child("Biodata/Data1/height");
                          refDataa.once().then((DataSnapshot dataSnapShot) {
                            setState(() {
                              retrievedTinggi = dataSnapShot.value;
                            });
                          });
                        }),
                  ),
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    "Your body weight: ",
                    style: GoogleFonts.lato(fontSize: 20.0),
                  ),
                  new Text(
                    hasilbmi(),
                    style: GoogleFonts.lato(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                        textStyle: TextStyle(color: Colors.limeAccent[400])),
                  ),
                ],
              ),
            ],
          ),
        ),
        new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, top: 60.0, bottom: 10.0),
              child: new Text("Daily Food Recommendation",
                  style: GoogleFonts.merriweather(
                      fontSize: 23.0, fontWeight: FontWeight.w800)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: new Container(
                height: 260.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8.0,
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15.0, right: 15.0),
                            child: new Container(
                              height: 60.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.green[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10.0),
                                child: new Text("Breakfast",
                                    style: GoogleFonts.lato(fontSize: 20.0),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          new Text(
                            retrievedBreakfast,
                            style: GoogleFonts.lato(fontSize: 20.0),
                          ),
                        ],
                      ),
                      new Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15.0, right: 15.0),
                            child: new Container(
                              height: 60.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.red[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10.0),
                                child: new Text("Lunch",
                                    style: GoogleFonts.lato(fontSize: 20.0),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          new Text(
                            retrievedLunch,
                            style: GoogleFonts.lato(fontSize: 20.0),
                          ),
                        ],
                      ),
                      new Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15.0, right: 15.0),
                            child: new Container(
                              height: 60.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.orange[200],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10.0),
                                child: new Text("Dinner",
                                    style: GoogleFonts.lato(fontSize: 20.0),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ),
                          new Text(
                            retrievedDinner,
                            style: GoogleFonts.lato(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 30.0, bottom: 10.0),
                  child: new Text("Health Information",
                      style: GoogleFonts.merriweather(
                          fontSize: 23.0, fontWeight: FontWeight.w800)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Container(
                    height: 125.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 8.0,
                          )
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 18.0, bottom: 10.0),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            children: [
                              new Text(
                                retrievedJudull,
                                style: GoogleFonts.lato(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          new Row(
                            children: [
                              new Text(
                                retrievedpenuliss,
                                style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          new Row(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  String urll = retrievedlinkk;
                                  launch(urll);
                                },
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF26A69A),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                    right: 12,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    'Cek Selengkapnya',
                                    style: TextStyle(
                                      color: Color(0xFFF2F2F2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    )));
  }
}
