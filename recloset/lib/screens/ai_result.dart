import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../widgets/radial_gauge.dart';
import '../widgets/donationTile.dart';

class AiResult extends StatefulWidget {
  const AiResult({super.key});

  @override
  State<AiResult> createState() => _AiResultState();
}

class _AiResultState extends State<AiResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final tipContainerWidth = screenWidth * 0.903125;
    final tipContainerHeight = screenWidth * 0.3125;

    final emptybox = screenWidth * 0.0625;
    final donationcontainerwidth = screenWidth * 0.75555555555;
    final donationcontainerHeight = screenWidth * 0.25;
    final donationimagewidth = screenWidth * 0.18;

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: emptybox),
              //tip container
              Container(
                padding: const EdgeInsets.all(20),
                width: tipContainerWidth,
                height: tipContainerHeight,
                decoration: BoxDecoration(
                  color: const Color(0xffC0BCFF).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 30,
                          color: Color(0xff081854),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Tip!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff081854),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'If the clothes are too stained (over level 30), consider recycling them instead of donating.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff081854),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: emptybox),

              //RadialGauge container
              const RadialGauge(
                value: 1,
                needleLength: 150,
              ),
              SizedBox(height: emptybox),

              //Donation List Container
              Container(
                width: screenWidth,
                // 높이를 고정하지 않음
                decoration: BoxDecoration(
                  color: const Color(0xffC0BCFF).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    SizedBox(height: emptybox),
                    DonationTile(
                      width: tipContainerWidth,
                      height: donationcontainerHeight,
                      imageWidth: donationimagewidth,
                      imagePath: 'assets/images/beautifulstore_logo2.png',
                      title: '아름다운 가게',
                      description: '지역사회와 함께하는 나눔 가게입니다.',
                    ),
                    // 다른 DonationTile 추가 가능
                    SizedBox(height: emptybox),
                    DonationTile(
                      width: tipContainerWidth,
                      height: donationcontainerHeight,
                      imageWidth: donationimagewidth,
                      imagePath: 'assets/images/goodwill_logo.png',
                      title: 'GoodWill',
                      description: '지역사회와 함께하는 나눔 가게입니다.',
                    ),
                    // 다른 DonationTile 추가 가능
                    SizedBox(height: emptybox),
                    DonationTile(
                      width: tipContainerWidth,
                      height: donationcontainerHeight,
                      imageWidth: donationimagewidth,
                      imagePath: 'assets/images/newhope_logo.png',
                      title: 'Newhope',
                      description: '지역사회와 함께하는 나눔 가게입니다.',
                    ),
                    // 다른 DonationTile 추가 가능
                    SizedBox(height: emptybox),
                    DonationTile(
                      width: tipContainerWidth,
                      height: donationcontainerHeight,
                      imageWidth: donationimagewidth,
                      imagePath: 'assets/images/otcan_logo.png',
                      title: 'Otcan',
                      description: '지역사회와 함께하는 나눔 가게입니다.',
                    ),
                    // 다른 DonationTile 추가 가능
                    SizedBox(height: emptybox),
                  ],
                ),
              ),
              SizedBox(height: emptybox),
            ],
          ),
        ),
      ),
    );
  }
}
