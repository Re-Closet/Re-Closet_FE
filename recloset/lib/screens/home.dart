import 'package:flutter/material.dart';
import 'package:recloset/screens/rewardscreen.dart';
import '../widgets/online_donation_card.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../widgets/bottom_navigation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final String accessToken;

  const HomeScreen({
    super.key,
    required this.accessToken,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final FlipCardController controller1;
  late final FlipCardController controller2;
  late final FlipCardController controller3;
  late final FlipCardController controller4;

  int totalReward = 0;

  @override
  void initState() {
    super.initState();
    controller1 = FlipCardController();
    controller2 = FlipCardController();
    controller3 = FlipCardController();
    controller4 = FlipCardController();

    _fetchReward();
  }

  Future<void> _fetchReward() async {
    final uri =
        Uri.parse('https://recloset-114997745103.asia-northeast3.run.app/home');
    final response = await http.get(
      uri,
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    print('StatusCode: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print(jsonData);
      if (mounted) {
        setState(() {
          totalReward = jsonData['data']['totalReward'];
          print('totalReward updated to: $totalReward');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F3FF),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Color(0xff7067FF),
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            return SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: screenHeight,
                    color: const Color(0xffF4F3FF),
                  ),
                  _buildTopGradient(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 110,
                      horizontal: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRewardSection(screenWidth, screenHeight),
                        _buildHowToDonateSection(screenWidth, screenHeight),
                        _buildDonationTitle(),
                        _buildDonationCards(screenWidth, screenHeight),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        accessToken: widget.accessToken,
      ),
    );
  }

  Widget _buildTopGradient() {
    return Container(
      height: 155,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff7067FF),
            Color(0xffF4F3FF),
          ],
        ),
      ),
    );
  }

  Widget _buildRewardSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  builder: (context) => RewardScreen(
                    accessToken: widget.accessToken,
                  ),
                ),
              );
            },
            child: Container(
              width: screenWidth * 0.9027,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/profile.png',
                      width: screenWidth * 0.18975,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'point balance',
                          style: TextStyle(
                            color: Color(0xffCCCCCC),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalReward',
                          style: const TextStyle(
                            color: Color(0xff6C63FF),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Color(0xffCCCCCC),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHowToDonateSection(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          child: Container(
            alignment: Alignment.centerLeft,
            width: screenWidth * 0.9027,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff9791FF),
                  Color(0xffF3D1FB),
                ],
              ),
            ),
            child: Image.asset(
              'assets/images/how_to_donate_logo.png',
              height: screenHeight * 0.2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDonationTitle() {
    return const Text(
      'Where to donate online',
      style: TextStyle(
        color: Color(0xff081854),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDonationCards(double screenWidth, double screenHeight) {
    final List<Map<String, dynamic>> donationData = [
      {
        'name': 'OTCAN',
        'image': 'assets/images/otcan_logo.png',
        'url': 'https://otcan.org/godonation',
        'controller': controller1,
      },
      {
        'name': 'GOODWILL',
        'image': 'assets/images/goodwill_logo.png',
        'url': 'https://goodwillstore.org/donation/application.php',
        'controller': controller2,
      },
      {
        'name': 'Beautiful Store',
        'image': 'assets/images/beautifulshop_logo.png',
        'url':
            'https://share.beautifulstore.org/select-way?utm_source=homepage',
        'controller': controller3,
      },
      {
        'name': 'New Hope',
        'image': 'assets/images/newhope_logo.png',
        'url': 'https://m.youcan.or.kr/page/page169',
        'controller': controller4,
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: donationData.sublist(0, 2).map((data) {
              return DonationCard(
                donationName: data['name'],
                controller: data['controller'],
                frontImagePath: data['image'],
                backImagePath: data['image'],
                cardWidth: screenWidth * 0.4341,
                imageWidth: screenWidth * 0.1717,
                imageHeight: screenHeight * 0.1045,
                url: data['url'],
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: donationData.sublist(2).map((data) {
            return DonationCard(
              donationName: data['name'],
              controller: data['controller'],
              frontImagePath: data['image'],
              backImagePath: data['image'],
              cardWidth: screenWidth * 0.4341,
              imageWidth: screenWidth * 0.2717,
              imageHeight: screenHeight * 0.1045,
              url: data['url'],
            );
          }).toList(),
        ),
      ],
    );
  }
}
