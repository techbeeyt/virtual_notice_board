import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'loading_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;
  int pageIndex = 0;
  Color bottomBarColor = Colors.blue;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == 4;
              pageIndex = index;
              switch (index) {
                case 1:
                  bottomBarColor = const Color.fromARGB(255, 255, 115, 93);
                  break;
                case 3:
                  bottomBarColor = const Color.fromARGB(255, 247, 123, 66);
                  break;
                default:
                  bottomBarColor = Colors.blue;
              }
            });
          },
          children: [
            const ScreenOne(),
            const ScreenTwo(),
            const ScreenThree(),
            const ScreenFour(),
            ScreenFive(controller: controller),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              color: const Color.fromARGB(255, 249, 249, 249))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(4);
                    },
                    child: Text(
                      "SKIP",
                      style: TextStyle(color: bottomBarColor),
                    ),
                  ),
                  Center(
                      child: SmoothPageIndicator(
                    controller: controller,
                    count: 5,
                    effect: WormEffect(
                        spacing: 10,
                        dotColor: Colors.black26,
                        activeDotColor: bottomBarColor),
                    onDotClicked: (index) {
                      controller.animateToPage(index,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn);
                    },
                  )),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: bottomBarColor),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset('assets/images/onBoard2.svg'),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Get notices from CR',
                  style: TextStyle(
                    fontFamily: "Nunito",
                    color: Color.fromARGB(255, 255, 115, 93),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'All information from CR in one place',
                  style: TextStyle(
                    fontFamily: "Nunito",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset('assets/images/onBoard1.svg'),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              children: const [
                Text(
                  'Get notified instantly',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'You\'ll be notified immidiately .',
                  style: TextStyle(fontFamily: "Nunito"),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: SizedBox(
              width: size.width / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Get notified about ',
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                  Text(
                    'Class re-scheduling',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 70, 70, 70)),
                  ),
                  Text(
                    'Class cancellation',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 70, 70, 70)),
                  ),
                  Text(
                    'Class test date',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 70, 70, 70)),
                  ),
                  Text(
                    'Assignment due date',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 70, 70, 70)),
                  ),
                  Text(
                    'Homework reminder',
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Color.fromARGB(255, 70, 70, 70)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenFive extends StatelessWidget {
  final PageController controller;
  const ScreenFive({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: const Color.fromARGB(255, 249, 249, 249),
        child: Stack(
          children: [
            SvgPicture.asset('assets/images/onBoard5.svg'),
            Positioned(
              top: 100,
              left: 0,
              child: SizedBox(
                width: size.width,
                child: const Center(
                  child: Text(
                    'Are you ready ?',
                    style: TextStyle(
                      fontFamily: "Nunito",
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 100,
                right: 0,
                child: SizedBox(
                    width: size.width,
                    child: Center(
                        child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('showHome', true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoadingScreen(
                                          isLogged: false,
                                        )));
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                            primary: Colors.white,
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text(
                            'Let\'s go',
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.linear);
                          },
                          style: TextButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: const Text(
                            'No, take me back',
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  )
                )
              ),
          ],
        ),
      ),
    );
  }
}

class ScreenThree extends StatelessWidget {
  const ScreenThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset('assets/images/onBoard3.svg'),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Any query about notice ?',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Ask it, and get answer from your friends',
                  style: TextStyle(fontFamily: "Nunito"),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 150,
            left: 20,
            child: Text(
              '''It is your friend, who is always\nthere to help you . Ask them any query \nand get answer immediately .''',
              style: TextStyle(fontFamily: "Nunito"),
            ),
          ),
        ],
      ),
    );
  }
}

class ScreenFour extends StatelessWidget {
  const ScreenFour({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset('assets/images/onBoard4.svg'),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Manage your tasks',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: Color.fromARGB(255, 247, 123, 66),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Now it\'s easier to manage your tasks',
                  style: TextStyle(fontFamily: "Nunito"),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('Add, edit and see your tasks',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 247, 123, 66))),
                Text(
                  'Editable task manager',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
                Text(
                  'Get reminder for upcoming event or tasks',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
                Text(
                  'Easy and better task management',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
                Text(
                  'Automatic online bakcup',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
                Text(
                  'and more features',
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Color.fromARGB(255, 70, 70, 70)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
