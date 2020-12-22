import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class WaterEntryTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      // Can implement undo feature
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.grey.shade900 : Colors.grey.shade300,
            ),
          ),
        ),

      ),
    );
  }
}
