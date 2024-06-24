
import 'dart:async';
import 'package:flutter/material.dart';


class CountUpTimer extends StatefulWidget {
  bool startTimer ;
   CountUpTimer({required this.startTimer,super.key});
  String counter='';
get theCounter =>counter;

 late CountUpTimerState countUpTimerState ;

  @override
  State<StatefulWidget> createState() {
    countUpTimerState = CountUpTimerState();
    return countUpTimerState;
  }
  // @override
  // State<CountUpTimer> createState() => CountUpTimerState();
}

class CountUpTimerState extends State<CountUpTimer> {
  late Stopwatch _stopwatch;
   Timer? _timer;
  Duration _elapsed = Duration.zero;


  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    // print(widget.startTimer);
    if(widget.startTimer){
      _startTimer();
    }else{
      if(_timer!= null){
        stopTimer();
      }

    }
  }
  void restartTimer() {
    stopTimer();
    _stopwatch.reset();
    _startTimer();
  }
  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print("startTimer$_elapsed");
      setState(() {
        _elapsed = _stopwatch.elapsed;
      });
    });
  }

  void stopTimer() {
      _timer?.cancel();
      _stopwatch.stop();
      _elapsed = Duration.zero;
  }



String  _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
  return  widget.counter="${twoDigits(duration.inMinutes.remainder(60))}:"
        "${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _formatDuration(_elapsed),
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }
}
