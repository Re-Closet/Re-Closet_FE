import 'package:flutter/material.dart';

class RewardCard extends StatefulWidget {
  // 버튼이 눌릴 때 실행될 콜백
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Widget child;

  const RewardCard({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.onPressed,
  });

  @override
  State<RewardCard> createState() => _RewardCardState();
}

class _RewardCardState extends State<RewardCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
        // 원하는 액션 추가 가능
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: _isPressed
            ? Matrix4.translationValues(0, 4, 0)
            : Matrix4.identity(),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 228, 226, 254).withOpacity(0.9),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
