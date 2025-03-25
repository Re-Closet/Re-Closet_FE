import 'package:flutter/material.dart';

class SignUpButton extends StatefulWidget {
  // 버튼이 눌릴 때 실행될 콜백
  final VoidCallback onPressed;

  // 버튼에 표시할 텍스트
  final String text;

  const SignUpButton({
    super.key,
    required this.onPressed,
    this.text = '', // 기본값 설정 가능
  });

  @override
  _SignUpButton createState() => _SignUpButton();
}

class _SignUpButton extends State<SignUpButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          transform: _isPressed
              ? Matrix4.translationValues(0, 4, 0)
              : Matrix4.identity(),
          width: 326,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(77.5),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Image.asset(
                    'assets/images/google_logo.png',
                    width: 23.77,
                    height: 25.71,
                  ),
                ),
                Opacity(
                  opacity: 0.54,
                  child: Text(
                    widget.text, // <-- 수정: 전달받은 텍스트를 사용
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
