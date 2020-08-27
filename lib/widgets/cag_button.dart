import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  final String text;
  final onPressedAction;
  final bool secondStyle;

  CButton({@required this.text, this.onPressedAction, this.secondStyle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: OutlineButton(
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
        borderSide: BorderSide(
          width: 4.0,
          color: secondStyle ? Colors.deepOrange : Theme.of(context).primaryColor,
        ),
        onPressed: onPressedAction,
      ),
    );
  }
}
