import 'package:awesome_button/awesome_button.dart';
import 'package:flutter/material.dart';

import 'thingModel.dart';

// 添加 页面中的3行column,提取相同代码
// MyTextField 是 row [text, textfield]
var controller1 = TextEditingController();

var controller3 = TextEditingController();

class MyTextField extends StatefulWidget {
  final String labelText;

  final String helperText;
  final bool autofocus;
  TextInputType textType = TextInputType.text;
  var controller = TextEditingController();
  MyTextField({
    Key key,
    this.textType = TextInputType.text,
    @required this.labelText, // text 的内容
    this.helperText = '',
    @required this.controller, // 记录textfield 的内容
    this.autofocus = false, // 是否自动将光标移入textfield
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

// var controller2 = TextEditingController();
class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var addButtonOnPressed = () {
      if (controller1.text != null &&
          // controller2.text != null &&
          controller3.text != null &&
          int.tryParse(controller3.text) != null) {
        var thing = Thing(
            controller1.text,
            //  controller2.text,
            '',
            int.parse(controller3.text));
        controller1.clear();
        controller3.clear();
        Navigator.pop(context, thing);
      } else {
        Scaffold.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text("输入格式错误！")));
      }
    };
    var awesomeButton = AwesomeButton(
      blurRadius: 3.0,
      splashColor: Color.fromRGBO(255, 255, 255, .4),
      borderRadius: BorderRadius.circular(10.0),
      height: 30.0,
      width: 100.0,
      onTap: addButtonOnPressed,
      color: Colors.lightBlue,
      child: Text(
        "添加",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
    var bodyChildren = <Widget>[
      MyTextField(
        labelText: "事件",
        helperText: '',
        controller: controller1,
        autofocus: true,
      ),
      // MyTextField(
      //   labelText: "类型",
      //   controller: controller2,
      // ),
      MyTextField(
        labelText: "时长",
        controller: controller3,
        helperText: '分钟',
        textType: TextInputType.number,
      ),
      new Container(
        child: awesomeButton,
        margin: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
      ),
    ];
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('添加事件'),
        ),
        body: new ListView(
          padding: new EdgeInsets.fromLTRB(30, 50, 30, 10),
          children: <Widget>[
            new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: bodyChildren),
          ],
        ));
  }
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.widget.controller,
        autofocus: this.widget.autofocus,
        // focusNode: _node,
        decoration: InputDecoration(
          labelText: this.widget.labelText,
          labelStyle: TextStyle(
            inherit: true,
            fontWeight: FontWeight.normal,
          ),
          helperText: this.widget.helperText,
          hintText: '',
          // errorText: '',
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => this.widget.controller.clear(),
          ),
          filled: true,
          fillColor: Colors.white,
          enabled: true,
        ),
        keyboardType: this.widget.textType,
        textAlign: TextAlign.center,
        obscureText: false,
        autocorrect: false,
        maxLengthEnforced: false,
        onChanged: (value) {
          //todo 当输入文本改变时会触发
        });
  }
}
