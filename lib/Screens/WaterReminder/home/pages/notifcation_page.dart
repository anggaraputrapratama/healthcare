import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthcare/Screens/WaterReminder/widgets/buttons/custom_wide_flat_button.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {

  AnimationController _fadeInController;

  @override
  void initState() {
    super.initState();
    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fadeInController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final notifications = snapshot.data;
                _fadeInController.forward();
                if (notifications.isEmpty)
                  return Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/no_notification.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                  );
                return Expanded(
                  child: AnimatedBuilder(
                    animation: _fadeInController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeInController.value,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return NotificationTile(
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              }
              return Expanded(child: SizedBox());
            },
          ),
          CustomWideFlatButton(
            onPressed: navigateToNotificationCreation,
            backgroundColor: Colors.blue.shade300,
            foregroundColor: Colors.blue.shade900,
            isRoundedAtBottom: false,
          ),
        ],
      ),
    );
  }

  Future<void> navigateToNotificationCreation() async {
    Navigator.of(context).push(
      MaterialPageRoute(
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  smallHeight,

                  smallHeight,
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 28,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
            ),
          ],
        ),
      ),
    );
  }

  SizedBox get smallHeight => SizedBox(height: 8);
}
