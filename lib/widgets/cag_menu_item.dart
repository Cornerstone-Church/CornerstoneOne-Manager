import 'package:flutter/material.dart';

class CMenuItem extends StatelessWidget {
  /// Creates an item that can be used for selection
  final AssetImage backgroundImage;
  final String text;
  final bool whiteText;
  final String routeName;
  CMenuItem(
      {this.backgroundImage = const AssetImage(''),
      @required this.text,
      this.whiteText = false,
      @required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Stack(
            children: <Widget>[
              Image(
                image: backgroundImage,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                  child: Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: whiteText ? Colors.white : Color(0xff34495e)),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
