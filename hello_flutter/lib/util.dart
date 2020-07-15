import 'package:flutter/material.dart';
import 'package:fancy_dialog/FancyAnimation.dart';
import 'package:fancy_dialog/FancyGif.dart';
import 'package:fancy_dialog/FancyTheme.dart';
import 'package:fancy_dialog/fancy_dialog.dart';

class DismissBg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      //这里使用ListTile因为可以快速设置左右两端的Icon
      child: ListTile(
        leading: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        trailing: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // 超出0.4像素，且返回会黑屏
    // FancyDialog(
    //   title: "Fancy Gif Dialog",
    //   descreption:
    //       "",
    //   animationType: FancyAnimation.BOTTOM_TOP,
    //   theme: FancyTheme.FANCY,
    //   gifPath: FancyGif.MOVE_FORWARD, //'./assets/walp.png',
    //   okFun: () => Navigator.of(context).pop(true),
    //   cancelFun: () => Navigator.of(context).pop(),
      
    // );
    AlertDialog(
      title: Text("提示"),
      content: Text("您确定要删除当前任务吗?"),
      actions: <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        FlatButton(
          child: Text("删除"),
          onPressed: () {
            Navigator.of(context).pop(true); //关闭对话框
          },
        ),
      ],
    );
  }
}

class GetThing extends StatelessWidget {
  // Todo: 构造函数添加其他参数
  const GetThing({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("提示"),
      content: Text("您确定要删除当前任务吗?"),
      actions: <Widget>[
        FlatButton(
          child: Text("取消"),
          onPressed: () => Navigator.of(context).pop(), //关闭对话框
        ),
        FlatButton(
          child: Text("删除"),
          onPressed: () {
            Navigator.of(context).pop(true); //关闭对话框
          },
        ),
      ],
    );
  }
}
