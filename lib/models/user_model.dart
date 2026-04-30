enum SmokingType { cigarette, vape, both }

class User {
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime lastLogin;
  final int totalPuffs;
  final int totalCigarettes;
  final int cravingsReported;
  final String language;
  final String petName;
  final SmokingType smokingType;
  final int dailyUsage;
  final double vapePrice;
  final int vapeDurationDays;
  final double cigarettePackPrice;
  final int dailyCigarettes;
  final bool isConfigured;

  const User({
    required this.name,
    required this.email,
    required this.createdAt,
    required this.lastLogin,
    required this.totalPuffs,
    required this.totalCigarettes,
    required this.cravingsReported,
    required this.language,
    required this.petName,
    required this.smokingType,
    required this.dailyUsage,
    required this.vapePrice,
    required this.vapeDurationDays,
    required this.cigarettePackPrice,
    required this.dailyCigarettes,
    required this.isConfigured,
  });

  double get estimatedDailyCost {
    final vapeDailyCost =
        vapeDurationDays > 0 ? vapePrice / vapeDurationDays : 0;
    final cigaretteDailyCost = (cigarettePackPrice / 20) * dailyCigarettes;

    return (switch (smokingType) {
      SmokingType.vape => vapeDailyCost,
      SmokingType.cigarette => cigaretteDailyCost,
      SmokingType.both => vapeDailyCost + cigaretteDailyCost,
    })
        .toDouble();
  }

  User copyWith({
    String? name,
    String? email,
    DateTime? createdAt,
    DateTime? lastLogin,
    int? totalPuffs,
    int? totalCigarettes,
    int? cravingsReported,
    String? language,
    String? petName,
    SmokingType? smokingType,
    int? dailyUsage,
    double? vapePrice,
    int? vapeDurationDays,
    double? cigarettePackPrice,
    int? dailyCigarettes,
    bool? isConfigured,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      totalPuffs: totalPuffs ?? this.totalPuffs,
      totalCigarettes: totalCigarettes ?? this.totalCigarettes,
      cravingsReported: cravingsReported ?? this.cravingsReported,
      language: language ?? this.language,
      petName: petName ?? this.petName,
      smokingType: smokingType ?? this.smokingType,
      dailyUsage: dailyUsage ?? this.dailyUsage,
      vapePrice: vapePrice ?? this.vapePrice,
      vapeDurationDays: vapeDurationDays ?? this.vapeDurationDays,
      cigarettePackPrice: cigarettePackPrice ?? this.cigarettePackPrice,
      dailyCigarettes: dailyCigarettes ?? this.dailyCigarettes,
      isConfigured: isConfigured ?? this.isConfigured,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt.toIso8601String(),
      'lastLogin': lastLogin.toIso8601String(),
      'totalPuffs': totalPuffs,
      'totalCigarettes': totalCigarettes,
      'cravingsReported': cravingsReported,
      'language': language,
      'petName': petName,
      'smokingType': smokingType.name,
      'dailyUsage': dailyUsage,
      'vapePrice': vapePrice,
      'vapeDurationDays': vapeDurationDays,
      'cigarettePackPrice': cigarettePackPrice,
      'dailyCigarettes': dailyCigarettes,
      'isConfigured': isConfigured,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLogin: DateTime.parse(json['lastLogin']),
      totalPuffs: json['totalPuffs'],
      totalCigarettes: json['totalCigarettes'],
      cravingsReported: json['cravingsReported'],
      language: json['language'] ?? 'pt',
      petName: json['petName'] ?? 'Puff',
      smokingType: SmokingType.values.firstWhere(
        (e) => e.name == json['smokingType'],
        orElse: () => SmokingType.cigarette,
      ),
      dailyUsage: json['dailyUsage'] ?? 10,
      vapePrice: (json['vapePrice'] ?? 50).toDouble(),
      vapeDurationDays: json['vapeDurationDays'] ?? 7,
      cigarettePackPrice: (json['cigarettePackPrice'] ?? 10).toDouble(),
      dailyCigarettes: json['dailyCigarettes'] ?? 10,
      isConfigured: json['isConfigured'] ?? false,
    );
  }
}
