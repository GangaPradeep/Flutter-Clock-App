// ignore_for_file: file_names, prefer_const_constructors, deprecated_member_use, avoid_print, unnecessary_string_interpolations, sized_box_for_whitespace
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:clock/Widgets/buttonWidget.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  late int hours = 0, minutes = 0, seconds = 1;
  late Duration duration =
      Duration(hours: hours, minutes: minutes, seconds: seconds);
  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    reset(Duration(hours: 0, minutes: 0, seconds: 1));
  }

  void reset(Duration d) {
    if (countDown) {
      setState(() => duration = d);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer(Duration d) {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime(d));
  }

  void addTime(Duration d) {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset(Duration(hours: 0, minutes: 0, seconds: 0));
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          buildTime(),
          SizedBox(
            height: 60,
          ),
          buildButtons()
        ],
      ),
    );
  }

//For the time
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

// For the dialog box which is used for selecting the time
  int maxVal = 0;
  int vals = 0;
  Future _timedialog(String val, int vals, int maxVal) async {
    await showDialog(
        context: context,
        useSafeArea: true,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 30,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.9),
                    borderRadius: BorderRadius.circular(20)),
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      CustomNumberPicker(
                        valueTextStyle: TextStyle(fontSize: 30),
                        initialValue: vals,
                        maxValue: maxVal,
                        minValue: 0,
                        step: 1,
                        onValue: (value) {
                          setState(() {
                            vals = int.parse(value.toString());
                          });
                          if (val == "HOURS") {
                            setState(() {
                              hours = int.parse(value.toString());
                            });
                          }
                          if (val == "MINUTES") {
                            setState(() {
                              minutes = int.parse(value.toString());
                            });
                          }
                          if (val == "SECONDS") {
                            setState(() {
                              seconds = int.parse(value.toString());
                            });
                          }
                          setState(() {
                            duration = Duration(
                                hours: hours,
                                minutes: minutes,
                                seconds: seconds);
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"))
                    ]),
              ),
            ));
  }

// For each time format
  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.black12,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$time",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 50),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          RaisedButton(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              onPressed: () {
                if (header == "HOURS") {
                  setState(() {
                    vals = hours;
                    maxVal = 24;
                  });
                }
                if (header == "MINUTES") {
                  setState(() {
                    vals = minutes;
                    maxVal = 60;
                  });
                }
                if (header == "SECONDS") {
                  setState(() {
                    vals = seconds;
                    maxVal = 60;
                  });
                }
                _timedialog(header, vals, maxVal);
              },
              child: Text(header, style: TextStyle(color: Colors.black45))),
        ],
      );
// For Start and Stop Buttons
  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    return isRunning
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: 'STOP',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    }
                  }),
              SizedBox(
                width: 12,
              ),
              ButtonWidget(text: "CANCEL", onClicked: stopTimer),
            ],
          )
        : ButtonWidget(
            text: "Start Timer!",
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              startTimer(
                  Duration(hours: hours, minutes: minutes, seconds: seconds));
            });
  }
}
