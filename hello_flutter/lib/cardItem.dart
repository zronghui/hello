import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_app/thingModel.dart';
import 'package:flutter_daydart/flutter_daydart.dart';
import 'thingModel.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class CardItem extends StatefulWidget {
  const CardItem(
      {Key key, this.onTap, @required this.thing, this.selected: false})
      : assert(thing != null),
        super(key: key);

  final VoidCallback onTap;
  final Thing thing;
  final bool selected;

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  double progressValue = 0;
  Thing thing;
  bool before;
  bool after;
  bool doing;
  DayDart startTime;
  DayDart endTime;
  Timer _timer;
  void startTimer() {
    const period = const Duration(milliseconds: 1000);
    _timer = Timer.periodic(period, (timer) {
      setState(() {});
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    thing = widget.thing;
    startTime = widget.thing.startTime;
    endTime = widget.thing.endTime;
    assert(startTime != null);
    assert(endTime != null);
    startTimer();
    super.initState();
    // new Timer.periodic(Duration(milliseconds: 1000), (Timer t) {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var timeSpanText =
        '${startTime.format(fm: 'HH:mm:ss')} ~ ${endTime.format(fm: 'HH:mm:ss')}';
    var timeSpan = Text(timeSpanText + '(${thing.duration} min)',
        textAlign: TextAlign.center);
    var name = Text('''${thing.name}''');
    // var duration = Text('''${widget.thing.duration} min''');

    before = DayDart().isBefore(startTime);
    after = DayDart().isAfter(endTime);
    doing = !before && !after;

    var progressBar;
    if (before) {
      progressValue = 0;
      progressBar = Container();
    } else if (after) {
      progressValue = 1;
      progressBar = Container();
    } else if (doing) {
      var passedTime = DateTime.now().millisecondsSinceEpoch -
          startTime.toDateTime().millisecondsSinceEpoch;
      progressValue = passedTime / thing.duration / 60000;

      progressBar = SizedBox(
          height: 15,
          width: 300,
          child: FaProgressBar(progressValue: progressValue));
    }

    var cardColor;
    if (before) {
      cardColor = Colors.blueGrey[50];
    } else if (after) {
      cardColor = null;
    } else if (doing) {
      cardColor = null;
    }
    return Container(
      margin: new EdgeInsets.fromLTRB(5, 5, 5, 0),
      padding: new EdgeInsets.fromLTRB(0, 0, 0, 5),
      decoration: new BoxDecoration(
        border: new Border.all(width: 2.0, color: Colors.lightBlue[100]),
        color: cardColor,
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            selected: doing,
            title: name,
            subtitle: timeSpan,
            dense: true,
            onTap: () {},
          ),
          progressBar,
        ],
      ),
    );
  }
}

class FaProgressBar extends StatefulWidget {
  const FaProgressBar({
    Key key,
    @required this.progressValue,
  }) : super(key: key);

  final double progressValue;

  @override
  _FaProgressBarState createState() => _FaProgressBarState();
}

class _FaProgressBarState extends State<FaProgressBar> {
  @override
  Widget build(BuildContext context) {
    int progress100;
    progress100 = (widget.progressValue * 100).round();
    // if (progressValue != 0) {
    //   progress100 = (progressValue * 100).floor() + 1;
    // }
    return FAProgressBar(
      currentValue: progress100,
      displayText: '%',
      progressColor: Colors.lightBlue[200],
      maxValue: 100,
      animatedDuration: Duration(seconds: 0),
    );
  }
}
