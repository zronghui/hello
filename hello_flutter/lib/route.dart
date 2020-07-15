import 'package:flutter/material.dart';

class ScreenArguments {
  final String name;
  final String type;
  final int duration;

  ScreenArguments(this.name, this.type, this.duration);
}

// 2. 创建组件来获取参数
// A Widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Center(
        child: Text(args.type+args.duration.toString()),
      ),
    );
  }
}


