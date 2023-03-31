import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;


  const ButtonWidget({
    required this.onClicked, required this.text,
  }) : super();



  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).primaryColor, // background (button) color
      foregroundColor: Colors.white, // foreground (text) color
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    onPressed: onClicked,

    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}