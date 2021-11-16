import 'dart:convert';

import 'package:flutter/material.dart';

class TmEvent {
  final String title;
  final DateTimeRange dateTimeRange;

  const TmEvent(this.title, this.dateTimeRange);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'start': dateTimeRange.start.toIso8601String(),
      'end': dateTimeRange.end.toIso8601String(),
    };
  }

  static TmEvent fromMap(Map<String, dynamic> map) {
    return TmEvent(
      map['title'],
      DateTimeRange(
          start: DateTime.parse(map["start"]), end: DateTime.parse(map["end"])),
    );
  }

  String toJson() => json.encode(toMap());

  static TmEvent fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(title: $title, dateTimeRange: $dateTimeRange)';
  }
}
