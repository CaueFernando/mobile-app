enum PetStage { newborn, puppy, young, adult, mature, elder }

enum PetMood { happy, excited, sad, sleeping, proud }

class Pet {
  final String name;
  final PetStage stage;
  final PetMood mood;
  final int daysWithoutNicotine;
  final double moneySaved;
  final int vcoins;
  final int happiness; // 0-100
  final int health; // 0-100
  final DateTime createdAt;
  final DateTime lastUpdate;

  const Pet({
    required this.name,
    required this.stage,
    required this.mood,
    required this.daysWithoutNicotine,
    required this.moneySaved,
    required this.vcoins,
    required this.happiness,
    required this.health,
    required this.createdAt,
    required this.lastUpdate,
  });

  // Copy with para facilitar atualizações
  Pet copyWith({
    String? name,
    PetStage? stage,
    PetMood? mood,
    int? daysWithoutNicotine,
    double? moneySaved,
    int? vcoins,
    int? happiness,
    int? health,
    DateTime? createdAt,
    DateTime? lastUpdate,
  }) {
    return Pet(
      name: name ?? this.name,
      stage: stage ?? this.stage,
      mood: mood ?? this.mood,
      daysWithoutNicotine: daysWithoutNicotine ?? this.daysWithoutNicotine,
      moneySaved: moneySaved ?? this.moneySaved,
      vcoins: vcoins ?? this.vcoins,
      happiness: happiness ?? this.happiness,
      health: health ?? this.health,
      createdAt: createdAt ?? this.createdAt,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  // Converter para JSON (para storage)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stage': stage.toString().split('.').last,
      'mood': mood.toString().split('.').last,
      'daysWithoutNicotine': daysWithoutNicotine,
      'moneySaved': moneySaved,
      'vcoins': vcoins,
      'happiness': happiness,
      'health': health,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdate': lastUpdate.toIso8601String(),
    };
  }

  // Criar a partir de JSON
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      stage: PetStage.values.firstWhere(
        (e) => e.toString().split('.').last == json['stage'],
      ),
      mood: PetMood.values.firstWhere(
        (e) => e.toString().split('.').last == (json['mood'] ?? 'happy'),
      ),
      daysWithoutNicotine: json['daysWithoutNicotine'],
      moneySaved: json['moneySaved'].toDouble(),
      vcoins: json['vcoins'],
      happiness: json['happiness'],
      health: json['health'],
      createdAt: DateTime.parse(json['createdAt']),
      lastUpdate: DateTime.parse(json['lastUpdate']),
    );
  }

  @override
  String toString() =>
      'Pet(name: $name, stage: $stage, days: $daysWithoutNicotine)';
}
