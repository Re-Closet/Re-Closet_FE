import 'package:flutter/material.dart';

Widget donationCard({
  required String imagePath,
  required double cardWidth,
  required double cardHeight,
  required double imageWidth,
  required double imageHeight,
}) {
  return Container(
    width: cardWidth,
    height: cardHeight,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1), // 그림자 색상 및 투명도
          spreadRadius: 0,
          blurRadius: 12,
          offset: const Offset(0, 6), // x=0, y=6 → 아래 방향 그림자
        ),
      ],
    ),
    child: Center(
      child: Image.asset(
        imagePath,
        width: imageWidth,
        height: imageHeight,
      ),
    ),
  );
}
