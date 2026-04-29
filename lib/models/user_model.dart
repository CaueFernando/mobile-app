class User {
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime lastLogin;
  final int totalPuffs;
  final int totalCigarettes;
  final int cravingsReported;

  const User({
    required this.name,
    required this.email,
    required this.createdAt,
    required this.lastLogin,
    required this.totalPuffs,
    required this.totalCigarettes,
    required this.cravingsReported,
  });

  User copyWith({
    String? name,
    String? email,
    DateTime? createdAt,
    DateTime? lastLogin,
    int? totalPuffs,
    int? totalCigarettes,
    int? cravingsReported,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      totalPuffs: totalPuffs ?? this.totalPuffs,
      totalCigarettes: totalCigarettes ?? this.totalCigarettes,
      cravingsReported: cravingsReported ?? this.cravingsReported,
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
    );
  }
}
