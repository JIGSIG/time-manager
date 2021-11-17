import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_manager_mobile_app/app.dart';
import 'package:time_manager_mobile_app/model/core/event_core.dart';
import 'package:time_manager_mobile_app/provider/auth_provider.dart';
import 'package:time_manager_mobile_app/provider/clock_provider.dart';
import 'package:time_manager_mobile_app/provider/workingtimes_provider.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final DateTime now = DateTime.now();
  late final ValueNotifier<List<TmEvent>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Stack(
            children: [
              const StopWatchTimerPage(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: Center(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({Key? key}) : super(key: key);

  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countdownDuration = Duration(minutes: 0);
  Duration duration = const Duration();
  Timer? timer;
  final userProvider = getIt<TmUserProvider>();
  final clockProvider = getIt<ClockProvider>();
  bool loading = true;
  bool countDown = true;
  late final StreamSubscription streamSubscription;

  @override
  void initState() {
    super.initState();
    clockProvider.getClock(userId: userProvider.getUser!.id);
    streamSubscription = clockProvider.clockStream.listen((snapshot) {
      snapshot.fold((l) => null, (r) {
        if (r.status == true) {
          Timestamp lastClockIn = Timestamp.fromDate(r.time);
          Timestamp currentTime = Timestamp.now();
          final timeElapsed =
              (currentTime.seconds - 3600) - lastClockIn.seconds;
          duration = Duration(seconds: timeElapsed);
          timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
        }
      });
      loading = false;
      setState(() {});
    });
    reset();
  }

  @override
  void dispose() {
    timer?.cancel();
    streamSubscription.cancel();
    super.dispose();
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    clockProvider.setClock(userId: userProvider.getUser!.id);
  }

  void addTime() {
    setState(() {
      final seconds = duration.inSeconds + 1;
      duration = Duration(seconds: seconds);
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() {
      timer?.cancel();
      clockProvider.setClock(userId: userProvider.getUser!.id);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                bottom: MediaQuery.of(context).size.height * .15,
                right: 0,
                left: 0,
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildTime(),
                          const SizedBox(
                            height: 80,
                          ),
                          buildButtons()
                        ],
                      ),
              ),
            ],
          ),
        ),
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(header, style: const TextStyle(color: Colors.white)),
        ],
      );

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = !(duration.inSeconds == 0);
    return isRunning || isCompleted
        ? ButtonWidget(
            text: "Stop Timer!",
            color: Colors.white,
            backgroundColor: Colors.black,
            onClicked: () {
              stopTimer(resets: true);
            })
        : ButtonWidget(
            text: "Start Timer!",
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              startTimer();
            });
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ));
}
