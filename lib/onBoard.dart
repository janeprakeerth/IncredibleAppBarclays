import 'package:flutter/material.dart';
import 'package:incredibleapp/HomePage.dart';
import 'package:incredibleapp/intro_screen1.dart';
import 'package:incredibleapp/intro_screen2.dart';
import 'package:incredibleapp/intro_screen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  PageController _controller = PageController()
;
  bool onLastPage =  false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [PageView(
          onPageChanged: (index){
            setState(() {
              onLastPage = (index == 2);
            });
          },
          controller: _controller,
          children: [
            intro_screen1(),
            intro_screen2(),
            intro_screen3()
          ],
        ),
          //dot indicators
           Container(alignment: Alignment(0,0.75),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   //skip
                   onLastPage?
                    GestureDetector(
                      child: Text('done'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return HomePage();
                        }));
                        },
                    ): GestureDetector(
                     child: Text('next'),
                     onTap: (){
                       _controller.nextPage(duration: Duration(microseconds: 500), curve: Curves.easeIn);
                     },
                   ) ,

                   //dot indicator
                   SmoothPageIndicator(controller: _controller, count: 3),

                   //next
                 ],
               ))
        ]
      ),
    );
  }
}
