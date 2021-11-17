import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/event_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/provider/workingtimes_provider.dart';
import 'package:time_manager_mobile_app/view/home_page.dart';

class AdminCalendar extends StatefulWidget {
  const AdminCalendar({Key? key}) : super(key: key);

  @override
  _AdminCalendarState createState() => _AdminCalendarState();
}

class _AdminCalendarState extends State<AdminCalendar> {
  final DateTime now = DateTime.now();
  late final ValueNotifier<List<TmEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final provider = getIt<WorkingTimesProvider>();
  final userProvider = getIt<TmUserProvider>();
  late final StreamSubscription<dynamic> streamSubscription;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  LinkedHashMap<DateTime, List<TmEvent>> kEvents =
      LinkedHashMap<DateTime, List<TmEvent>>();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    provider.getAllWorkingTimes(userId: userProvider.getUser!.id);
    streamSubscription = provider.workingTimesStream.listen((snapshot) {
      snapshot.fold(
          (l) => null,
          (r) => kEvents = LinkedHashMap<DateTime, List<TmEvent>>(
                equals: isSameDay,
                hashCode: getHashCode,
              )..addAll(r));
      setState(() {
        _selectedDay = _selectedDay;
        _focusedDay = _focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  @override
  Future<void> dispose() async {
    streamSubscription.cancel();
    _selectedEvents.dispose();
    super.dispose();
  }

  List<TmEvent> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<TmEvent> _getEventsForRange(DateTime start, DateTime end) {
    List<DateTime> daysInRange(DateTime first, DateTime last) {
      final dayCount = last.difference(first).inDays + 1;
      return List.generate(
        dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
      );
    }

    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<TmEvent>(
            firstDay: DateTime(now.year),
            lastDay: DateTime(now.year + 1),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: HexColor('#FFA400'),
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: true,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<TmEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        // ignore: avoid_print
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
