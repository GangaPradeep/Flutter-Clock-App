// ignore_for_file: file_names, prefer_const_constructors, unnecessary_new, unnecessary_string_interpolations, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  String getSystemTime() {
    var now = new DateTime.now();
    return new DateFormat.jm().format(now);
  }

  String getSystemDate() {
    var date = new DateTime.now();
    return new DateFormat.yMMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
//For Anolog Clock
        Align(
          alignment: Alignment.center,
          child: SizedBox(
              width: 300,
              height: 300,
              child: Card(
                shape: CircleBorder(),
                elevation: 15.0,
                color: Colors.black,
                child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FlutterAnalogClock(
                      dateTime: DateTime.now(),
                      dialPlateColor: Colors.transparent,
                      hourHandColor: Colors.white,
                      minuteHandColor: Colors.white,
                      secondHandColor: Colors.white,
                      numberColor: Colors.white,
                      borderColor: Colors.transparent,
                      tickColor: Colors.white,
                      centerPointColor: Colors.white,
                      showBorder: true,
                      showTicks: true,
                      showMinuteHand: true,
                      showSecondHand: true,
                      showNumber: true,
                      borderWidth: 2.0,
                      hourNumberScale: .50,
                      hourNumbers: [
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10',
                        '11',
                        '12'
                      ],
                      isLive: true,
                      width: 200.0,
                      height: 200.0,
                      decoration: const BoxDecoration(),
                    )),
              )),
        ),
        SizedBox(
          height: 60,
        ),
// For Digital Clock
        TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
          return Text("${getSystemTime()}",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Color(0xff2d386b),
                    fontSize: 30,
                    fontWeight: FontWeight.w400),
              ));
        }),
// For Date
        TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
          return Text("${getSystemDate()}",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Color(0xff2d386b),
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ));
        }),
      ],
    );
  }
}
