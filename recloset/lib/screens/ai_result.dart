import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../widgets/radial_gauge.dart';
import '../widgets/donationTile.dart';

class AiResult extends StatefulWidget {
  final String response;
  final String solution;
  final double confidence;
  final String prediction;
  final bool resultType;

  const AiResult({
    super.key,
    required this.response,
    required this.solution,
    required this.confidence,
    required this.prediction,
    required this.resultType,
  });

  @override
  State<AiResult> createState() => _AiResultState();
}

class _AiResultState extends State<AiResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffC0BCFF),
      ),
      backgroundColor: Colors.white,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    final screenWidth = MediaQuery.of(context).size.width;

    final tipContainerWidth = screenWidth * 0.903125;
    final tipContainerHeight = screenWidth * 0.3125;
    final emptyBoxHeight = screenWidth * 0.0625;
    final donationContainerHeight = screenWidth * 0.25;
    final donationImageWidth = screenWidth * 0.18;

    final donationData = [
      ['assets/images/beautifulstore_logo2.png', '아름다운 가게'],
      ['assets/images/goodwill_logo.png', 'GoodWill'],
      ['assets/images/newhope_logo.png', 'Newhope'],
      ['assets/images/otcan_logo.png', 'Otcan'],
    ];

    final List<String> solutions =
        widget.solution.split(',').map((e) => e.trim()).toList();

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: emptyBoxHeight),

              // Tip Container
              SizedBox(
                width: tipContainerWidth,
                // height: tipContainerHeight,
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                          fontSize: 13,
                          color: Color(0xff081854),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: emptyBoxHeight),

              // RadialGauge
              RadialGauge(
                value: widget.confidence * 100,
                needleLength: 150,
              ),

              SizedBox(height: emptyBoxHeight),

              // Donation List Container
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: const Color(0xffC0BCFF).withOpacity(0.25),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    SizedBox(height: emptyBoxHeight),
                    if (widget.confidence * 100 <= 30)
                      ...donationData.map(
                        (data) => Padding(
                          padding: EdgeInsets.only(
                              bottom: emptyBoxHeight), // 기부 가능 -> 기부처
                          child: DonationTile(
                            width: tipContainerWidth,
                            height: donationContainerHeight,
                            imageWidth: donationImageWidth,
                            imagePath: data[0],
                            title: data[1],
                            description: '지역사회와 함께하는 나눔 가게입니다.',
                          ),
                        ),
                      ),
                    if (widget.confidence * 100 > 30) // 기부 불가능 -> recycling 방법
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 16.0, left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '👚 Re-closet Recycling Solution ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 1,
                              decoration: const BoxDecoration(
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: solutions.map((sol) {
                                return Container(
                                  margin:
                                      const EdgeInsets.only(right: 8), // 버튼 간격
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff746BFF),
                                  ),
                                  child: Text(
                                    sol,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.response,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                height: 1.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: emptyBoxHeight),
            ],
          ),
        ),
      ),
    );
  }
}
