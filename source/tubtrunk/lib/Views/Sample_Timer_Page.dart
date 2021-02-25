import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:condition/condition.dart';
import 'Popup_Base.dart';

class Sample_Timer_Page extends StatefulWidget {
  @override
  _Sample_Timer_Page_State createState() => _Sample_Timer_Page_State();
}

class _Sample_Timer_Page_State extends State<Sample_Timer_Page> {
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Reward after time == 0 test")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Count down"),
            onPressed: startTimer,
          ),
          Conditioned(
            cases: [
              Case(_start == 0, builder: () => new Popup_Base().MoneyRecievePopup())
            ],
            defaultBuilder: () => Text('$_start'),
          ),
          //Text('$_start'),
        ],
      )),
    );
  }
}
