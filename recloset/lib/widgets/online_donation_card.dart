import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationCard extends StatefulWidget {
  final FlipCardController controller;
  final String frontImagePath;
  final String backImagePath;
  final double cardWidth;
  final double cardHeight;
  final double imageWidth;
  final double imageHeight;
  final String donationName;
  final String url;

  const DonationCard({
    super.key,
    required this.controller,
    required this.frontImagePath,
    required this.backImagePath,
    required this.cardWidth,
    required this.cardHeight,
    required this.imageWidth,
    required this.imageHeight,
    required this.donationName,
    required this.url,
  });

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  bool _isPressed = false;

// URL 열기 함수
  void _launchURL() async {
    final Uri uri = Uri.parse(widget.url); // 외부에서 받은 url 사용
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.url}';
    }
  }

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
          rotateSide: RotateSide.left,
          onTapFlipping: false,
          axis: FlipAxis.horizontal,
          controller: widget.controller,

          //전면
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
                ),
              ),
            ),
          ),

          //후면
          backWidget: Container(
            height: widget.cardHeight,
            width: widget.cardWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.donationName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.cardHeight * 0.4239,
                  ),
                  GestureDetector(
                    onTap: _launchURL,
                    child: Stack(
                      alignment: Alignment.center, // 전체 Stack에서 중앙 정렬 적용
                      children: [
                        Container(
                          width: widget.cardWidth * 0.8573,
                          height: widget.cardHeight * 0.2334,
                          decoration: BoxDecoration(
                            color: const Color(0xff6C63FF),
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        const Text(
                          'Go',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
