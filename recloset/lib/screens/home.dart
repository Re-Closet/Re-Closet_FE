import 'package:flutter/material.dart';
import 'package:recloset/screens/reward.dart';
import '../widgets/online_donation_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../widgets/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final FlipCardController controller1 = FlipCardController();
    final FlipCardController controller2 = FlipCardController();
    final FlipCardController controller3 = FlipCardController();
    final FlipCardController controller4 = FlipCardController();

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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RewardScreen()),
                        );
                      },
                      child: Stack(
                        children: [
                          // my reward container 배경
                          Container(
                            width: screenWidth * 0.9027,
                            height: screenHeight * 0.117,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/face.png',
                                    width: screenWidth * 0.22975,
                                  ),
                                  const SizedBox(width: 15),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'point balance',
                                        style: TextStyle(
                                          color: Color(0xffCCCCCC),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 4),
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
                                  const Spacer(), // 남은 공간을 차지해서 아이콘을 오른쪽으로 밀어줌
                                  const Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Color(0xffCCCCCC),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        //How to Donate 배경
                        Container(
                          width: screenWidth * 0.9027,
                          height: screenHeight * 0.157,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff9791FF),
                                Color(0xffF3D1FB),
                              ],
                            ),
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
                        Image.asset(
                          'assets/images/how_to_donate_logo.png',
                          width: screenWidth * 0.6166,
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

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DonationCard(
                          donationName: 'OTCAN',
                          controller: controller1,
                          frontImagePath: 'assets/images/otcan_logo.png',
                          backImagePath: 'assets/images/otcan_logo.png',
                          cardWidth: screenWidth * 0.4341,
                          cardHeight: screenHeight * 0.1774,
                          imageWidth: screenWidth * 0.1717,
                          imageHeight: screenHeight * 0.1045,
                          url: 'https://otcan.org/godonation',
                        ),
                        DonationCard(
                          donationName: 'GOODWILL',
                          controller: controller2,
                          frontImagePath: 'assets/images/goodwill_logo.png',
                          backImagePath: 'assets/images/goodwill_logo.png',
                          cardWidth: screenWidth * 0.4341,
                          cardHeight: screenHeight * 0.1774,
                          imageWidth: screenWidth * 0.1851,
                          imageHeight: screenHeight * 0.1045,
                          url:
                              'https://goodwillstore.org/donation/application.php',
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 위젯 빌드할 때
                      // donationCard(
                      //   controller: controller,
                      //   frontImagePath: 'image/01.png',
                      //   backImagePath: 'image/02.jpg',
                      //   cardWidth: 140,
                      //   cardHeight: 200,
                      //   imageWidth: 120,
                      //   imageHeight: 180,
                      // );

                      DonationCard(
                        donationName: 'Beautiful Store',
                        controller: controller3,
                        frontImagePath: 'assets/images/beautifulshop_logo.png',
                        backImagePath: 'assets/images/beautifulshop_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.3735,
                        imageHeight: screenHeight * 0.0891,
                        url:
                            'https://share.beautifulstore.org/select-way?utm_source=homepage&utm_medium=display&utm_content=top&_gl=1*aenboj*_gcl_au*OTQ2MjAzMDU0LjE3NDIxMzQ4NjQ.*_ga*MTA3MTM4NTEuMTc0MjEzNDg2NA..*_ga_NLGK74R7WV*MTc0MzA5MDAyMy43LjAuMTc0MzA5MDAyMy42MC4wLjA.&_ga=2.137134899.224096786.1743090022-10713851.1742134864',
                      ),

                      DonationCard(
                        donationName: 'New Hope',
                        controller: controller4,
                        frontImagePath: 'assets/images/newhope_logo.png',
                        backImagePath: 'assets/images/newhope_logo.png',
                        cardWidth: screenWidth * 0.4341,
                        cardHeight: screenHeight * 0.1774,
                        imageWidth: screenWidth * 0.3,
                        imageHeight: screenHeight * 0.2388,
                        url: 'https://m.youcan.or.kr/page/page169',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
