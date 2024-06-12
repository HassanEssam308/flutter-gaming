// import 'dart:async';
// import 'package:flutter/material.dart';
//
// class CountUpTimer  {
//
//   late final Stopwatch _stopwatch =Stopwatch();
//   late Timer _timer ;
//   Duration _elapsed = Duration.zero;
//   String _counter="";
//
//
//   void startTimer() {
//     _stopwatch.start();
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       _elapsed = _stopwatch.elapsed;
//     });
//   }
//
//   void stopTimer() {
//     print('_stopTimer$_elapsed');
//     _stopwatch.stop();
//     _timer.cancel();
//     _elapsed = Duration.zero;
//
//   }
//
//
//
//   String  _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//
//     return  _counter="${twoDigits(duration.inMinutes.remainder(60))}:"
//         "${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//   get theTime => _counter;
//
//   Widget counterWidget() {
//     print('counterWidget ${_formatDuration(_elapsed)}');
//     return Center(
//       child: Text(
//         _formatDuration(_elapsed),
//         style: const TextStyle(fontSize: 20.0),
//       ),
//     );
//   }
//
// }

/////////////////////////////////
import 'dart:async';
import 'package:flutter/material.dart';


class CountUpTimer extends StatefulWidget {
  bool startTimer ;
   CountUpTimer({required this.startTimer,super.key});
  String counter='';
get theCounter =>counter;

  @override
  State<CountUpTimer> createState() => CountUpTimerState();
}

class CountUpTimerState extends State<CountUpTimer> {
  late Stopwatch _stopwatch;
   Timer? _timer;
  Duration _elapsed = Duration.zero;


  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    print(widget.startTimer);
    if(widget.startTimer){
      _startTimer();
    }else{
      if(_timer!= null){
        _stopTimer();
      }

    }
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('_startTimer${widget.counter}');
      setState(() {
        _elapsed = _stopwatch.elapsed;
      });
    });
  }

  void _stopTimer() {
    print('_stopTimer${widget.counter}');
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
    _stopTimer();
  }
}
