import 'package:flutter/material.dart';

class CustomWideFlatButton extends StatelessWidget {
  const CustomWideFlatButton({
    Key key,
    this.text = 'Create',
    @required this.onPressed,
    @required this.backgroundColor,
    @required this.foregroundColor,
    this.isRoundedAtBottom = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isRoundedAtBottom;

  final roundedBorder = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(5),
      bottomRight: Radius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.only(left: 120, bottom: 40,right: 120),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: onPressed,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(40), side: BorderSide(color: Colors.white)),
        color: backgroundColor,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: Text(
            text,
            style: TextStyle(
              color: foregroundColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,

          ),
        ),
      ),
    ),
    );
  }
}
