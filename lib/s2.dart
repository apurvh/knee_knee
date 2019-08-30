import 'package:flutter/material.dart';
import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 's3.dart';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'dart:async';
//import 'dart:io';
import 'dart:ui';
//import 'package:charcode/ascii.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'main.dart';
import 'package:flutter/services.dart';

class S2 extends StatefulWidget {
  @override
  _S2State createState() => _S2State();
}

class _S2State extends State<S2> {
  Timer _timer;
  int _start = 5;

  void startTimer() {
    print("...timer started.");
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => S3(),
              ),
            );
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  // Get battery level.
//  String _batteryLevel = 'Unknown battery level.';
  static const platform = const MethodChannel('get_w_data');

  Future<void> _getWData() async {

    List _getWData = new List();

    try {
      final List result = await platform.invokeMethod('xxxxx');
      _getWData = result;
    } on PlatformException catch (e) {
      _getWData = ["Failed to get battery level: '${e.message}'."];
    }

    setState(() {
      getWData = _getWData;
    });
  }


//  Future connectB() async {
//    String _address;
//    FlutterBluetoothSerial.instance.address.then((address) {
//      setState(() { _address = address; });
//    });
//    // Some simplest connection :F
//    try {
//      BluetoothConnection connection = await BluetoothConnection.toAddress(_address);
//      print('Connected to the device');
//
//      connection.input.listen((Uint8List data) {
//        print('Data incoming: ${ascii.decode(data)}');
//        connection.output.add(data); // Sending data
//
//        if (ascii.decode(data).contains('!')) {
//          connection.finish(); // Closing connection
//          print('Disconnecting by local host');
//        }
//      }).onDone(() {
//        print('Disconnected by remote request');
//      });
//    }
//    catch (exception) {
//      print('Cannot connect, exception occured');
//    }
//  }

  @override
  void initState() {
    startTimer();
    _getWData();
//    connectB();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 12.0, // has the effect of softening the shadow
                    spreadRadius: 2.0, // has the effect of extending the shadow
                    offset: Offset(
                      10.0, // horizontal, move right 10
                      10.0, // vertical, move down 10
                    ),
                  ),
                ]),
                child: new Image.asset(
                  'assets/img/knee_animation.gif',
                  width: 240.0,
                  height: 360.0,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Move Your knee!",
                style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,color: Colors.red),
              ),
              SizedBox(
                height: 15,
              ),

              Text(
                "$_start Seconds",
                style: TextStyle(fontSize: 11.0,color: Colors.red[800]),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                child: new LinearPercentIndicator(
                  width: 200.0,
                  lineHeight: 2.0,
                  percent: (1 - _start / 5),
                  backgroundColor: Colors.grey[200],
                  progressColor: Colors.red[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
