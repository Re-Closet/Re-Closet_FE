import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';

class DonationCard extends StatefulWidget {
  final FlipCardController controller;
  final String frontImagePath;
  final String backImagePath;
  final double cardWidth;
  final double cardHeight;
  final double imageWidth;
  final double imageHeight;

  const DonationCard({
    super.key,
    required this.controller,
    required this.frontImagePath,
    required this.backImagePath,
    required this.cardWidth,
    required this.cardHeight,
    required this.imageWidth,
    required this.imageHeight,
  });

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
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
        widget.controller.flipcard(); // 카드 뒤집기
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: SizedBox(
        width: widget.cardWidth,
        height: widget.cardHeight,
        child: FlipCard(
          // rotateSide: RotateSide.left,
          onTapFlipping: false,
          axis: FlipAxis.horizontal,
          controller: widget.controller,
          frontWidget: Center(
            child: Container(
              height: widget.cardHeight,
              width: widget.cardWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 206, 202, 255)
                        .withOpacity(0.5),
                    blurRadius: 12,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  widget.frontImagePath,
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          backWidget: Container(
            height: widget.cardHeight,
            width: widget.cardWidth,
            decoration: BoxDecoration(
              color: Colors.deepPurple[100],
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: Image.asset(
                widget.backImagePath,
                width: widget.imageWidth,
                height: widget.imageHeight,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
