import 'package:dots_indicator/dots_indicator.dart';
import 'package:final_shop_app/mdules/Login/login_screen.dart';
import 'package:final_shop_app/shared/components/compnents.dart';
import 'package:final_shop_app/shared/network/local/cache_helper.dart';
import 'package:final_shop_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoarding1.png',
      title: 'On Board 1 Title',
      body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding3.png',
      title: 'On Board 2 Title',
      body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoarding2.png',
      title: 'On Board 3 Title',
      body: 'On Board 3 Body',
    ),
  ];

  int _positionDots = 0;
  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submit();
            },
            text: "skip",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  setState(() {
                    _positionDots = index;
                  });
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40.0,
              ),
            ),
            Row(
              children: [
                DotsIndicator(
                  dotsCount: boarding.length,
                  position: _positionDots.toDouble(),
                  decorator: DotsDecorator(
                    activeColor: defaultColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(30.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          microseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
