import 'package:flutter/material.dart';
import 'package:recloset/screens/home.dart';
import 'package:recloset/widgets/sign_up_button.dart';
import '../widgets/basic_lg_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

void _handleButtonPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
}

class _LoginScreen extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
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
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Recloset <앱이름>
            const Padding(
              padding: EdgeInsets.only(bottom: 45),
              child: Text(
                'Recloset',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),

                    //id 입력란
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(), // 외곽선
                        labelText: "id", // 라벨
                        hintText: "email & id", // 힌트 텍스트
                        prefixIcon:
                            Icon(Icons.account_circle_rounded), // 앞쪽에 표시할 아이콘
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 6,
                    ),
                    //pwd 입력란
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(), // 외곽선
                        labelText: "password", // 라벨
                        hintText: "password", // 힌트 텍스트
                        prefixIcon: Icon(Icons.password), // 앞쪽에 표시할 아이콘
                      ),
                    ),
                  ),

                  //비밀번호 찾기
                  Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //로그인 버튼
            BasicLgButton(
              textColor: const Color(0xff081854),
              width: screenWidth * 0.9222,
              height: screenHeight * 0.0873,
              text: 'Login',
              onPressed: () => _handleButtonPressed(context),
              color: const Color(0xffF4F3FF),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/images/line_left.png',
                  ),
                ),
                const Text(
                  'Or Sign up With',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Image.asset(
                    'assets/images/line_right.png',
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 41),
              child: SignUpButton(
                text: 'Continue with Google',
                onPressed: () => _handleButtonPressed(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
