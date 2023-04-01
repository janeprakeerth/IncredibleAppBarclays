import 'package:flutter/material.dart';

class intro_screen1 extends StatelessWidget {
  const intro_screen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage(
            "https://mologmedia.s3.ap-south-1.amazonaws.com/first_page_image.png"),
      ),
      color: Color(0xffFFF1ED),
    );
  }
}
