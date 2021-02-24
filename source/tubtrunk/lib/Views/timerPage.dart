import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  CountDownController _controller = CountDownController();
  int _duration = 1800;
  bool stopped = true;
  bool resumable = false;
  String stopStartButtonText = "Start";

  _button({String title, VoidCallback onPressed}) {
    return Expanded(
      child: RaisedButton(
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
        color: Color(0xfffc575e),
      ),
    );
  }

  String _timerTextFormat() {
    if (_duration > 3600) {
      return CountdownTextFormat.HH_MM_SS;
    } else if (_duration > 60) {
      return CountdownTextFormat.MM_SS;
    } else {
      return CountdownTextFormat.S;
    }
  }

  void _showDurationPickerDialog() async {
    final selectedDurationInMinutes = await showDialog<int>(
      context: context,
      builder: (context) => DurationPickerDialog(
        initialDuration: _duration,
      ),
    );

    if (selectedDurationInMinutes != null) {
      setState(() {
        _duration = selectedDurationInMinutes * 60;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => _showDurationPickerDialog(),
          child: CircularCountDownTimer(
            duration: _duration,
            initialDuration: 0,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 1.5,
            height: MediaQuery.of(context).size.height / 1.5,
            ringColor: Colors.grey[300],
            ringGradient: null,
            fillColor: Colors.orange,
            fillGradient: null,
            backgroundColor: Color(0xfffc575e),
            backgroundGradient: null,
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
              fontSize: 33.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textFormat: _timerTextFormat(),
            isReverse: true,
            isReverseAnimation: true,
            isTimerTextShown: true,
            autoStart: false,
            onStart: () {
              print('Countdown Started');
              resumable = true;
            },
            onComplete: () {
              print('Countdown Ended');
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          _button(
            title: stopStartButtonText,
            onPressed: () {
              if (stopped) {
                resumable == true ? _controller.resume() : _controller.start();
              } else {
                _controller.pause();
              }
              setState(() {
                stopped
                    ? stopStartButtonText = "Stop"
                    : stopStartButtonText = "Start";
              });
              stopped = !stopped;
            },
          ),
          SizedBox(
            width: 10,
          ),
          _button(
            title: "Reset",
            onPressed: () {
              _controller.restart(duration: _duration);
              _controller.pause();
              setState(() {
                stopped = true;
                resumable = false;
                stopStartButtonText = "Start";
              });
            },
          ),
        ],
      ),
    );
  }
}

class DurationPickerDialog extends StatefulWidget {
  final int initialDuration;
  const DurationPickerDialog({Key key, this.initialDuration}) : super(key: key);

  @override
  _DurationPickerDialogState createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  int _durationInMinutes;

  @override
  void initState() {
    super.initState();
    _durationInMinutes = (widget.initialDuration / 60).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter time'),
      insetPadding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 300.0,
      ),
      content: Container(
        child: Slider(
          value: _durationInMinutes.toDouble(),
          min: 10,
          max: 240,
          divisions: 46,
          onChanged: (value) {
            setState(() {
              _durationInMinutes = value.toInt();
              print(_durationInMinutes);
            });
          },
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context, _durationInMinutes);
          },
          child: Text('Done'),
        )
      ],
    );
  }
}
