import 'dart:convert';
import 'dart:math';

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
  final Map<String, dynamic> rawJson;

  const AiResult({
    super.key,
    required this.response,
    required this.solution,
    required this.confidence,
    required this.prediction,
    required this.resultType,
    required this.rawJson,
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
    final emptyBoxHeight = screenWidth * 0.0625;
    final donationContainerHeight = screenWidth * 0.25;
    final donationImageWidth = screenWidth * 0.18;

    final donationData = [
      ['assets/images/beautifulstore_logo2.png', '아름다운 가게'],
      ['assets/images/goodwill_logo.png', 'GoodWill'],
      ['assets/images/newhope_logo.png', 'Newhope'],
      ['assets/images/otcan_logo.png', 'Otcan'],
    ];

    final recyclingData = [
      ['assets/images/arket_logo.png', 'Arket'],
      ['assets/images/hm_logo.png', 'H&M'],
    ];

    final List<String> solutions =
        widget.solution.split(',').map((e) => e.trim()).toList();

    final String prettyJson =
        const JsonEncoder.withIndent('  ').convert(widget.rawJson);

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: emptyBoxHeight),

              // Tip Container
              SizedBox(
                width: tipContainerWidth,
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
                          padding: EdgeInsets.only(bottom: emptyBoxHeight),
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
                    if (widget.confidence * 100 > 30)
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 16.0, right: 16.0, left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '👚 Re-closet Contamination Class ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8982FE),
                              ),
                            ),
                            Container(
                              height: 1,
                              decoration: const BoxDecoration(
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Detected: ${widget.prediction}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff4285F4),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              '👖 Re-closet Recycling Solution ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 1,
                              decoration: const BoxDecoration(
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: solutions.map((sol) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8),
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
                            const SizedBox(height: 10),
                            Text(
                              widget.response,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                height: 1.7,
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Text(
                              '📍 Go to recycling site ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff8982FE),
                              ),
                            ),
                            Container(
                              height: 1,
                              decoration: const BoxDecoration(
                                color: Color(0xff8982FE),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...recyclingData.map(
                              (data) => Padding(
                                padding:
                                    EdgeInsets.only(bottom: emptyBoxHeight),
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
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: emptyBoxHeight),

              // 🛠 Raw JSON Debug Section
              // 🛠 Raw JSON Debug Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Raw Debug',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xfff5f5f5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: SingleChildScrollView(
                              child: Text(
                                prettyJson,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      },
                      icon: const Icon(Icons.code, color: Color(0xff081854)),
                      label: const Text(
                        'Show Raw JSON',
                        style: TextStyle(
                          color: Color(0xff081854),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff5f5f5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
