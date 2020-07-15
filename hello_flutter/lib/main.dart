import 'dart:async';

import 'package:dragable_flutter_list/dragable_flutter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_daydart/flutter_daydart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'addRoute.dart';
import 'cardItem.dart';
import 'file.dart';
import 'thingModel.dart';
import 'util.dart';

void main() {
  runApp(new TestApp());
}

final Color color1 = Color(0xff54B7FF);

final Color color2 = Color(0xff4D7DE8);

final Color color3 = Color(0xff6067FF);

List<Thing> items = [];

isBusy() {
  if (items == null) {
    return false;
  }
  for (var i = 0; i < items.length; i++) {
    var before = DayDart().isBefore(items[i].startTime);
    var after = DayDart().isAfter(items[i].endTime);
    var doing = !before && !after;
    if (doing) {
      return true;
    }
  }
  return false;
}

getThings() async {
  print('-----get things start-----');
  var things = await readJSON();
  items = things;
  print('get things ' + items.toString());
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // String s = prefs.getString('thingList');
  // print(s);
  // print(json.decode(s));
  // var t = mapToThinglist(json.decode(s)['things']);
  // if(t!=null){
  //   items = t;
  // }
  print('-----get things end-----');
}

saveThings() async {
  print('-----save things start-----');
  ThingList thingList = ThingList(things: items);
  await writeJSON(thingList);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('thingList', json.encode(thingList));
  // print(json.encode(thingList));
  print('-----save things end-----');
}

updateItems(int index, [DayDart d]) async {
  DayDart referenceTime;
  if (d == null) {
    referenceTime = DayDart();
  } else {
    print('-----last modified time-----\n' + d.toString());
    referenceTime = d;
  }
  for (var i = index; i < items.length; i++) {
    if (d != null && items[0].endTime.isBefore(referenceTime)) {
      continue;
    }
    if (i == 0) {
      // 是列表第一个元素
      items[0].startTime = DayDart();
      items[0].endTime = items[0].startTime.add(items[0].duration, Units.MIN);
    } else if (items[i - 1].endTime.isBefore(referenceTime)) {
      // 如果前一个已经完成，开始时间为当前时间
      items[i].startTime = DayDart();
      items[i].endTime = items[i].startTime.add(items[i].duration, Units.MIN);
    } else {
      items[i].startTime = items[i - 1]
          .endTime
          .add((items[i - 1].duration * 60 / 5).floor(), Units.S);
      items[i].endTime = items[i].startTime.add(items[i].duration, Units.MIN);
    }
  }
  await saveThings();
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  mySetState() {
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('-----build-----');
    print(items);
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          _buildHeader(),
          // SizedBox(height: 40.0),
          Flexible(
            child: new DragAndDropList(
              items.length,
              itemBuilder: _buildItem,
              onDragFinish: (before, after) {
                print('on drag finish $before $after');
                Thing data = items[before];
                items.removeAt(before);
                items.insert(after, data);
                if (before != after) {
                  updateItems(before < after ? before : after);
                }
              },
              canDrag: (index) => true,
              canBeDraggedTo: (one, two) => true,
              dragElevation: 8.0,
            ),
          ),
          // new PouringHourglass()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _navigateAndDisplaySelection(context);
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.add),
      ),
    );
  }

  initItems() async {
    await getThings();
    mySetState();
    await updateItems(0, DayDart.fromDateTime(thingFile.lastModifiedSync()));
  }

  @override
  void initState() {
    print('-----init start-----');
    super.initState();
    requestStoragePermission();
    initItems();
    print('-----init end-----');
  }

  Container _buildHeader() {
    return Container(
      height: 130,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: -100,
            top: -150,
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color1, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color2,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Positioned(
            top: 50,
            left: 85,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [color3, color2]),
                  boxShadow: [
                    BoxShadow(
                        color: color3,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          new PouringHourglass(),
          Container(
            margin: const EdgeInsets.only(top: 10, left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text(
                //   "Himanshu",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 28.0,
                //       fontWeight: FontWeight.w700),
                // ),
                // SizedBox(height: 10.0),
                // Text(
                //   "2 remaining tasks",
                //   style: TextStyle(color: Colors.white, fontSize: 18.0),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Dismissible(
        // 必须是string, 用途：区分不同item
        key: Key(UniqueKey().toString()),
        direction: DismissDirection.startToEnd,
        crossAxisEndOffset: 0.1,
        movementDuration: const Duration(milliseconds: 200),
        // 滑动过程中的背景图标和颜色
        background: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
        // secondaryBackground: DecoratedBox(decoration: BoxDecoration(color: Colors.grey[600])),
        // DismissBg(),
        // 确认移除，弹出对话框
        confirmDismiss: (direction) async {
          var isDismissed = showDialog<bool>(
              context: context,
              builder: (context) {
                return new Alert();
              });
          return await isDismissed;
        },
        // 移除
        onDismissed: (direction) {
          print(items.length);
          items.removeAt(index);
          updateItems(index);
          print(items.length);
          mySetState();
        },
        // 包裹的子对象
        child: CardItem(
          thing: items[index],
          onTap: () {
            mySetState();
          },
        ));
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // 获取下个页面返回的thing对象
    var thing = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );
    if (thing != null) {
      // thing.startTime = DayDart();
      thing.endTime = DayDart().add(thing.duration, Units.MIN);
      items.insert(items.length, thing);
      updateItems(items.length - 1);
      mySetState();
    }
  }
}

class PouringHourglass extends StatefulWidget {
  const PouringHourglass({
    Key key,
  }) : super(key: key);

  @override
  _PouringHourglassState createState() => _PouringHourglassState();
}

class TestApp extends StatelessWidget {
  TestApp({Key key});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0), //定义提示文本样式
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      )),
      title: '今日事今日毕',
      home: new MyHomePage(
        title: '今日事今日毕',
        key: key,
      ),
    );
  }
}

class _PouringHourglassState extends State<PouringHourglass> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 50,
      child: SpinKitPouringHourglass(
        color: isBusy() ? Colors.lightBlueAccent : Colors.blueGrey[100],
        // color: Colors.blueGrey,
        size: 50,
      ),
    );
    // Container(
    //   margin: new EdgeInsets.fromLTRB(0, 20, 0, 30),
    //   child: SpinKitPouringHourglass(
    //     color: isBusy() ? Colors.lightBlueAccent : Colors.blueGrey[100],
    //     // color: Colors.blueGrey,
    //     size: 40,
    //   ),
    // );
  }

  @override
  void initState() {
    super.initState();
    new Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (this.mounted) {
        setState(() {});
      }
    });
  }
}
