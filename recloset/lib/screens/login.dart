import 'package:flutter/material.dart';
import 'package:recloset/widgets/sign_up_button.dart';
import '../widgets/basic_lg_button.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final Uri loginUrl = Uri.parse(
      'http://recloset-114997745103.asia-northeast3.run.app/api/login/google');
  Future<void> launchGoogleLogin(BuildContext context) async {
    const authUrl =
        'http://recloset-114997745103.asia-northeast3.run.app/api/login/google';
    const callbackUrlScheme = 'recloset';

    try {
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackUrlScheme,
      );

      final uri = Uri.parse(result);
      final accessToken = uri.queryParameters['accessToken'];

      if (accessToken != null) {
        print('accessToken: $accessToken');

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(accessToken: accessToken),
          ),
        );
      } else {
        print('accessToken 없음');
      }
    } catch (e) {
      print('로그인 실패: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkStoredToken();
  }

  Future<void> _checkStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken != null) {
      // 토큰이 있다면 바로 HomeScreen으로 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(accessToken: accessToken),
          ),
        );
      });
    }
  }

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
              Color(0xFF6C63FF),
              Color(0xFFD8D6FF),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xffF4F3FF),
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xffF4F3FF),
                        border: const OutlineInputBorder(),
                        labelText: "id",
                        hintText: "email & id",
                        prefixIcon: const Icon(Icons.account_circle_rounded),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xffF4F3FF),
                            width: 1.5,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xffF4F3FF),
                        border: const OutlineInputBorder(),
                        labelText: "password",
                        hintText: "password",
                        prefixIcon: const Icon(Icons.password),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BasicLgButton(
              textColor: const Color(0xff081854),
              width: screenWidth * 0.7861,
              height: screenHeight * 0.06731,
              text: 'Login',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "Email and password login is currently not supported."),
                  ),
                );
              },
              color: const Color(0xffF4F3FF),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffC4C4C4).withOpacity(0.2),
                          const Color(0xff8982FE),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    'Or Sign up With',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xff8982FE),
                          const Color(0xffC4C4C4).withOpacity(0.2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 41),
              child: SignUpButton(
                text: 'Continue with Google',
                onPressed: () => launchGoogleLogin(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
