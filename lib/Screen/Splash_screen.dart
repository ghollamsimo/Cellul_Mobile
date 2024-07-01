// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_pr/Student_App/Home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'Onboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<SplashScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 2);
                });
              },
              controller: _controller,
              children: [
                Onboard(
                  image: Image.asset(
                    'assets/onboarding-1.gif',
                    height: 350,
                  ),
                  title: "Cellule D'ecoute",
                  titleTextStyle: const TextStyle(
                    color: Color(0xff1F2937),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  description:
                      'You don\'t have to go far to find a good restaurant,\nwe have provided all the restaurants that is\nnear you',
                  descriptionTextStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(
                      0xff4B5563,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Onboard(
                  image: Image.asset(
                    'assets/onboarding-2.gif',
                    height: 350,
                  ),
                  title: 'Select the Favorites Menu',
                  titleTextStyle: const TextStyle(
                    color: Color(0xff1F2937),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  description:
                      'Now eat well, don\'t leave the house,You can\nchoose your favorite food only with\none click',
                  descriptionTextStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(
                      0xff4B5563,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Onboard(
                  image: Image.asset(
                    'assets/onboarding-3.gif',
                    height: 350,
                  ),
                  title: 'Good food at a cheap price',
                  titleTextStyle: const TextStyle(
                    color: Color(0xff1F2937),
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                  description:
                      'You can eat at expensive restaurants with\naffordable price',
                  descriptionTextStyle: const TextStyle(
                    fontSize: 12,
                    color: Color(
                      0xff4B5563,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 80, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xff4B5563),
                      fontSize: 20,
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 10,
                    activeDotColor: Color.fromARGB(255, 149, 60, 5),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (onLastPage) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(userId: null,)));
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color.fromARGB(255, 149, 60, 5),
                    size: 30,
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
