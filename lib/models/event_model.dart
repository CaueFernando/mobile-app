enum EventType { puff, cigarette, craving }

class Event {
  final String id;
  final EventType type;
  final DateTime timestamp;
  final String? notes;

  const Event({
    required this.id,
    required this.type,
    required this.timestamp,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString().split('.').last,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      type: EventType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      timestamp: DateTime.parse(json['timestamp']),
      notes: json['notes'],
    );
  }
}
