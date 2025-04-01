// reward_detail.dart
import 'package:flutter/material.dart';
import '../models/reward.dart';
import '../widgets/status_badge.dart';

class RewardDetailScreen extends StatelessWidget {
  final Reward reward;

  const RewardDetailScreen({super.key, required this.reward});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Reward Detail',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff979797),
          ),
          onPressed: () {
            Navigator.pop(context); // ← 뒤로 가기 기능
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 0.6,
            color: const Color(0xffCCCCCC),
          ),
          Image.asset('assets/images/place_holder.png'),
          Container(
            height: 0.6,
            color: const Color(0xffCCCCCC),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reward.donationSite,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                StatusBadge(status: reward.status),
              ],
            ),
          ),
          Container(
            color: const Color(0xffA982FE),
          )
        ],
      ),
    );
  }
}
