import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Heartbeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Beat extends StatefulWidget {
  @override
  _BeatState createState() => _BeatState();
}

class _BeatState extends State<Beat> {
  StreamSubscription _subscriptionTodo;

  String _todoName = "Display the todo name here";

  @override
  void initState() {
    //FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);

    FirebaseTodos.getTodoStream("HeartRate", _updateTodo)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionTodo != null) {
      _subscriptionTodo.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var itemTile = new ListTile(
      title: new Text("$_todoName"),
    );

    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          itemTile,
        ],
      ),
    );
  }

  _updateTodo(Todo value) {
    var name = value.name;
    setState(() {
      _todoName = name;
    });
  }
}

class Todo {
  final String key;
  String name;

  Todo.fromJson(this.key, Map data) {
    name = data['name'];
    if (name == null) {
      name = '';
    }
  }
}

class FirebaseTodos {
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getTodoStream(
      String todoKey, void onData(Todo todo)) async {
    String heartrate = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("HeartRate")
        .child(heartrate)
        .child(todoKey)
        .onValue
        .listen((Event event) {
      var todo = new Todo.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todo);
    });

    return subscription;
  }

  /// FirebaseTodos.getTodo("-KriJ8Sg4lWIoNswKWc4").then(_updateTodo);
  static Future<Todo> getTodo(String todoKey) async {
    Completer<Todo> completer = new Completer<Todo>();

    String accountKey = await Preferences.getAccountKey();

    FirebaseDatabase.instance
        .reference()
        .child("accounts")
        .child(accountKey)
        .child("todos")
        .child(todoKey)
        .once()
        .then((DataSnapshot snapshot) {
      var todo = new Todo.fromJson(snapshot.key, snapshot.value);
      completer.complete(todo);
    });

    return completer.future;
  }
}

class Preferences {
  static const String ACCOUNT_KEY = "accountKey";

  static Future<bool> setAccountKey(String accountKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ACCOUNT_KEY, accountKey);
    return prefs.commit();
  }

  static Future<String> getAccountKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountKey = prefs.getString(ACCOUNT_KEY);

    // workaround - simulate a login setting this
    if (accountKey == null) {
      accountKey = "-KriFiUADpl-X07hnBC-";
    }

    return accountKey;
  }
}
