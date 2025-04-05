import 'package:flutter/material.dart';
import '../widgets/basic_lg_button.dart';

class BasicLgButton extends StatefulWidget {
  // 버튼이 눌릴 때 실행될 콜백
  final VoidCallback onPressed;

  // 버튼에 표시할 텍스트
  final String text;
  final Color color;
  final double width;
  final double height;
  final Color textColor;

  const BasicLgButton({
    super.key,
    required this.onPressed,
    this.text = '',
    required this.color,
    required this.width,
    required this.height,
    required this.textColor,
    // 기본값 설정 가능
  });

  @override
  _BasicLgButtonState createState() => _BasicLgButtonState();
}

class _BasicLgButtonState extends State<BasicLgButton> {
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
          width: widget.width,
          height: widget.height,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(63),
          ),
          child: Center(
            child: Text(
              widget.text, // <-- 수정: 전달받은 텍스트를 사용
              style: TextStyle(
                fontSize: 17.6,
                fontWeight: FontWeight.bold,
                color: widget.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
