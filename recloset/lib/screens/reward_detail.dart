import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/reward.dart';
import '../widgets/status_badge.dart';

class RewardDetailScreen extends StatefulWidget {
  final int rewardId;
  final String accessToken;

  const RewardDetailScreen({
    super.key,
    required this.rewardId,
    required this.accessToken,
  });

  @override
  State<RewardDetailScreen> createState() => _RewardDetailScreenState();
}

class _RewardDetailScreenState extends State<RewardDetailScreen> {
  Reward? reward;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRewardDetail();
  }

  Future<void> fetchRewardDetail() async {
    final uri = Uri.parse(
      'https://recloset-114997745103.asia-northeast3.run.app/rewards/list/${widget.rewardId}',
    );

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      setState(() {
        reward = Reward.fromJson(jsonResponse['data']);
        isLoading = false;
      });
    } else {
      debugPrint('Failed to fetch reward detail: ${response.statusCode}');
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reward == null
              ? const Center(child: Text("No reward data available."))
              : Column(
                  children: [
                    Container(
                      height: 0.6,
                      color: const Color(0xffCCCCCC),
                    ),
                    reward!.imageUrl.isNotEmpty
                        ? Image.network(
                            reward!.imageUrl,
                            height: 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/images/place_holder.png');
                            },
                          )
                        : Image.asset('assets/images/place_holder.png'),
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
                            reward!.donationSite,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StatusBadge(status: reward!.status),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Reward Granted:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '+${reward!.rewardGranted}P',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7067FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
