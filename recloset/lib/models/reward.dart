class Reward {
  final int id;
  final String email;
  final String donationSite;
  final String status;
  final int rewardGranted;
  final String detailUrl;

  Reward({
    required this.id,
    required this.email,
    required this.donationSite,
    required this.status,
    required this.rewardGranted, //if status = "accepted",
    required this.detailUrl,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      email: json['email'],
      donationSite: json['donationSite'],
      status: json['status'],
      rewardGranted: json['rewardGranted'],
      detailUrl: json['detailUrl'],
    );
  }
}
