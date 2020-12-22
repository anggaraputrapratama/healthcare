import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/Screens/WaterReminder/home/pages/cups.dart';
import 'package:healthcare/Screens/WaterReminder/home/pages/drink_page.dart';
import 'package:healthcare/Screens/WaterReminder/home/pages/notifcation_page.dart';
import 'package:healthcare/Screens/WaterReminder/widgets/widgets/bottom_app_bar.dart';
import 'package:healthcare/Screens/WaterReminder/enums/enums.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({
    Key key,
  }) : super(key: key);


  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  int _currentIndex = 0;
  final List<Widget> _children = [

    DrinkPage(),
    NotificationPage(),

  ];
  bool isAnonymous = false;



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Water Reminder',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<PopupMenuChoices>(
                  child: Text('Cups'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).accentColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          FABBottomAppBarItem(iconData: Icons.home, text: 'Home'),
          FABBottomAppBarItem(iconData: Icons.alarm, text: 'Alarm'),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
  void onMenuSelection(PopupMenuChoices value, Path auth) async {
    switch (value) {
      case PopupMenuChoices.Cups:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CupsPage()),
        );
        setState(() {
        });
        break;
      default:
    }
  }

}
