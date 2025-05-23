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
            SizedBox(
              height: screenHeight * 0.09731,
            ),
            const Text(
              'Recloset',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.08149,
            ),
            Image.asset(
              'assets/images/intro.png',
              width: screenWidth * 0.7861,
              height: screenHeight * 0.4004,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05555),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Get started with \nDonating your clothes. ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09731,
            ),

            //Get Started button
            BasicLgButton(
              textColor: const Color(0xff081854),
              width: screenWidth * 0.7861,
              height: screenHeight * 0.06731,
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
