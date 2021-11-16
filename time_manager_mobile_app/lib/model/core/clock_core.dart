import 'dart:convert';

class TmClock {
  final DateTime time;
  final bool status;

  const TmClock({
    required this.time,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'status': status,
    };
  }

  static TmClock fromMap(Map<String, dynamic> map) {
    return TmClock(
      time: map['time'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static TmClock fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TmClock(time: $time, status: $status)';
  }
}
