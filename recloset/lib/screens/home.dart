import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xffF4F3FF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: const Color(0xffF4F3FF),
            ),

            //상단 gradient 부분
            Container(
              height: 155,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight, // Start direction
                  end: Alignment.bottomRight, // End direction
                  colors: [
                    Color(0xff7067FF), // Start Color
                    Color(0xffF4F3FF),
                    // End Color
                  ], // Customize your colors here
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 110,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //My reward
                  const Text(
                    'My reward',
                    style: TextStyle(
                      color: Color(0xff081854),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        //reward container 배경
                        Container(
                          width: screenWidth * 0.9027,
                          height: screenHeight * 0.117,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 30,
                            ), // 원하는 padding 값
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'point balance',
                                      style: TextStyle(
                                        color: Color(0xffCCCCCC),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 4), // 텍스트 사이 간격 추가
                                    Text(
                                      '1,980',
                                      style: TextStyle(
                                        color: Color(0xff6C63FF),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color(0xffCCCCCC),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'How to Donate',
                    style: TextStyle(
                      color: Color(0xff081854),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Stack(
                      children: [
                        //reward container 배경
                        Container(
                          width: screenWidth * 0.9027,
                          height: screenHeight * 0.157,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 4), // 텍스트 사이 간격 추가
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //online donation
                  const Text(
                    'Where to donate online',
                    style: TextStyle(
                      color: Color(0xff081854),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      donationCard(
                        imagePath: 'assets/images/otcan_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.1717,
                        imageHeight: screenHeight * 0.1045,
                      ),
                      donationCard(
                        imagePath: 'assets/images/goodwill_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.1851,
                        imageHeight: screenHeight * 0.1045,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      donationCard(
                        imagePath: 'assets/images/beautifulshop_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.3735,
                        imageHeight: screenHeight * 0.0891,
                      ),
                      donationCard(
                        imagePath: 'assets/images/newhope_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.3,
                        imageHeight: screenHeight * 0.2388,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
}
