class Reward {
  final int id;
  final String email;
  final String donationSite;
  final String status;
  final int rewardGranted;
  final String detailUrl;
  final String imageUrl;

  Reward({
    required this.id,
    required this.email,
    required this.donationSite,
    required this.status,
    required this.rewardGranted,
    required this.detailUrl,
    required this.imageUrl,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      email: json['email'] ?? '',
      donationSite: json['donationSite'] ?? '',
      status: (json['status'] as String?)?.toUpperCase() ?? 'UNKNOWN',
      rewardGranted: json['rewardGranted'] ?? 0,
      detailUrl: json['detailUrl'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
