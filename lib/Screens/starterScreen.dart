// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clock/Screens/mainScreen.dart';
class Starter extends StatefulWidget {
  const Starter({Key? key}) : super(key: key);
  @override
  _StarterState createState() => _StarterState();
}

class _StarterState extends State<Starter> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MainScreen()
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 120),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: 360,
                            height: 200,
                            child:const Align(
                                        alignment:Alignment.center,
                                        child: Text(
                                        "Clock",
                                        style:TextStyle(
                                            fontSize: 60,
                                            color: Colors.black,
                                            fontFamily: "Monoton"
                                          )
                                        )
                                      )
                          ),
                        ),
                        const SizedBox(height: 100),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 90,
                                height: 90,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.transparent,
                                      child: const Center(
                                          child: SpinKitDoubleBounce(
                                        color: Colors.grey,
                                        size: 50,
                                      )),
                                    )
                                  ],
                                )),
                          ],
                        )
                      ],
                    )
      ),
    );
  }
}
