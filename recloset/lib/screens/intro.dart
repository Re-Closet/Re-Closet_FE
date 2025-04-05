import 'package:flutter/material.dart';
import '../widgets/basic_lg_button.dart';
import 'login.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

void _handleButtonPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF6C63FF), // 예: 하늘색 계열
              Color(0xFFD8D6FF), // 더 연한 하늘색
            ],
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 60,
                bottom: 100,
              ),
              child: Text(
                'Recloset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Image.asset(
              'assets/images/intro.png',
              width: 283,
              height: 344,
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 50,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Get started with \nDonating your clothes. ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Get Started button
            BasicLgButton(
              textColor: const Color(0xff081854),
              width: screenWidth * 0.9222,
              height: screenHeight * 0.0873,
              text: 'Get Started',
              onPressed: () => _handleButtonPressed(context),
              color: const Color(0xffF4F3FF),
            )
          ],
        ),
      ),
    );
  }
}
