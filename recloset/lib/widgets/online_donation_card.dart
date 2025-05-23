import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationCard extends StatefulWidget {
  final FlipCardController controller;
  final String frontImagePath;
  final String backImagePath;
  final double cardWidth;
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

  // 스타일, 색상, 비율 상수화
  static const double _donationNameFontSize = 14;
  static const double _goButtonFontSize = 20;
  static const Color _goButtonColor = Color(0xff6C63FF);
  static const Color _shadowColor = Color.fromARGB(255, 206, 202, 255);

  static const EdgeInsets _donationNamePadding = EdgeInsets.all(10.0);

  static const double _goButtonWidthRatio = 0.8573;
  static const double _goButtonHeightRatio = 0.2334;
  static const double _spacingRatio = 0.4239;

  final BoxShadow _cardShadow = const BoxShadow(
    color: _shadowColor,
    blurRadius: 12,
    offset: Offset(4, 4),
  );

  void _launchURL() async {
    final Uri uri = Uri.parse(widget.url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.url}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.controller.flipcard();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        width: widget.cardWidth,
        child: FlipCard(
          rotateSide: RotateSide.left,
          onTapFlipping: false,
          axis: FlipAxis.horizontal,
          controller: widget.controller,
          frontWidget: _buildFront(),
          backWidget: _buildBack(),
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      width: widget.cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [_cardShadow],
      ),
      child: Center(
        child: Image.asset(
          widget.frontImagePath,
          width: widget.imageWidth,
          height: widget.imageHeight,
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Padding(
            padding: _donationNamePadding,
            child: Text(
              widget.donationName,
              style: const TextStyle(
                fontSize: _donationNameFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: _launchURL,
              child: Container(
                width: widget.cardWidth * _goButtonWidthRatio,
                decoration: BoxDecoration(
                  color: _goButtonColor,
                  borderRadius: BorderRadius.circular(32),
                ),
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: const Center(
                  child: Text(
                    'Go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
