import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:healthcare/Screens/WaterReminder/widgets/popups/custom_amount_popup.dart';

class CupAmountButton extends StatelessWidget {
  const CupAmountButton({
    Key key,
    this.amount = 0,
  }) : super(key: key);

  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (amount == 0) {
              } else {
              }
            },
            child: StreamBuilder<int>(
              initialData: 1,
              builder: (context, snapshot) {
                final selectedAmount = snapshot.data;
              },
            ),
          ),
          SizedBox(height: 8),
          if (amount != 0) Text('$amount ml') else Text('Custom'),
        ],
      ),
    );
  }


}

