import 'package:flutter/material.dart';
import 'package:healthcare/Screens/UserProfile/user_profile.dart';
import 'package:firebase_database/firebase_database.dart';

class MedicalRecords extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Lato",
        textTheme: TextTheme(),
      ),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
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

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  void initState() {
    super.initState();
    item = updatepenyakit("", "", "", "");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                            image: AssetImage("assets/icon/arrow_back.png")),
                        shape: BoxShape.circle),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => UserProfile()),
                        );
                      },
                    ),
                  ),
                  Text(
                    "Medical Records",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              Container(
                //padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "List of Illnesses",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 355.0,
                  child: items.length == 0
                      ? Text("No Data")
                      : ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Container(
                              height: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding:
                                          EdgeInsets.only(right: 8, top: 8),
                                      width: MediaQuery.of(context).size.width -
                                          2 * 16,
                                      child: Text(
                                        items[index].classification,
                                        style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color: Color(0xFF656565),
                                        ),
                                        textAlign: TextAlign.right,
                                      )),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Text(
                                      items[index].symptoms,
                                      style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          items[index].date,
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.normal),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ));
                          })),
              Container(
                padding: EdgeInsets.only(
                  right: 16,
                  left: 16,
                ),
                child: Row(children: <Widget>[
                  Expanded(child: Divider()),
                  Text(
                    "End of List",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal),
                  ),
                  Expanded(child: Divider()),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
