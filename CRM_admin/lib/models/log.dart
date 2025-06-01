class Log {
  final String event;
  final Map<String, dynamic> data;
  final DateTime timestamp;

  Log({
    required this.event,
    required this.data,
    required this.timestamp,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      event: json['event'] as String,
      data: Map<String, dynamic>.from(json['data'] as Map),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}
