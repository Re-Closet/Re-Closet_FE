import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:recloset/screens/uploadReward.dart';
import '../models/reward.dart';
import '../screens/reward_detail.dart';
import '../widgets/status_badge.dart';

class RewardScreen extends StatefulWidget {
  final String accessToken;

  const RewardScreen({super.key, required this.accessToken});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  List<Reward> rewards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    final uri = Uri.parse(
        'https://recloset-114997745103.asia-northeast3.run.app/rewards/list');
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];

      setState(() {
        rewards = data.map((item) => Reward.fromJson(item)).toList();
        isLoading = false;
      });
    } else {
      debugPrint('Failed to fetch rewards: ${response.statusCode}');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Rewards',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xff979797)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xff979797), size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      Uploadreward(accessToken: widget.accessToken),
                ),
              );
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 0.5,
                    color: const Color(0xffF5F5F5)),
                Expanded(
                  child: ListView.builder(
                    itemCount: rewards.length,
                    itemBuilder: (context, index) {
                      final reward = rewards[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      reward.donationSite,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff303030),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    StatusBadge(status: reward.status),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                                reward.rewardGranted > 0
                                    ? Text(
                                        '+${reward.rewardGranted}P',
                                        style: const TextStyle(
                                          color: Color(0xff7067FF),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RewardDetailScreen(
                                    rewardId: reward.id,
                                    accessToken: widget.accessToken,
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                              height: 0.5, color: const Color(0xffCCCCCC)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
