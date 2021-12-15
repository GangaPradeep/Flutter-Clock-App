// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, unused_field, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/services.dart';
import 'package:clock/Screens/aboutScreen.dart';
import 'package:clock/Screens/timerScreen.dart';
import 'package:clock/Screens/clockScreen.dart';
import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late bool _hideNavBar;
  int _selectedIndex = 1;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Widget _buildScreens(int index) {
    if (index == 2) {
      return AboutScreen();
    }

    if (index == 0) {
      return TimerScreen();
    } else {
      return ClockScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: _buildScreens(_selectedIndex),
        bottomNavigationBar: FancyBottomBar(
          selectedPosition: _selectedIndex,
          selectedColor: CupertinoColors.activeBlue,
          indicatorColor: CupertinoColors.white,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FancyBottomItem(
              icon: Icon(CupertinoIcons.timer),
              title: Text("Timer"),
            ),
            FancyBottomItem(
              icon: Icon(CupertinoIcons.clock),
              title: Text("Clock"),
            ),
            FancyBottomItem(
              icon: Icon(Icons.info_outline),
              title: Text("About"),
            ),
          ],
        ),
      ),
      onWillPop: () async {
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
                    height: 300,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Do you want to exit the app ?",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                              fontSize: 19,
                            )),
                          ),
                          SizedBox(height: 90),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Align(
                                //   alignment: Alignment.bottomRight,
                                //   child:
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.greenAccent.shade400,
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    child: Icon(Icons.check_rounded)),
                                // ),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.redAccent.shade400,
                                    onPressed: () {
                                      setState(() {
                                        _selectedIndex = 1;
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Icon(Icons.close_rounded)),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ));
        return false;
      },
    );
  }
}
