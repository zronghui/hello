import 'dart:convert';

import 'package:flutter_daydart/flutter_daydart.dart';

//  ThingList转string：
//     json.encode(things)
//   string转ThingList:
//     mapThingList(json.decode(s))

Thing mapToThing(Map<String, dynamic> m) {
  Thing thing = Thing(m['name'], m['type'], int.parse(m['duration']));
  thing.startTime = DayDart.fromString(m['startTime']);
  thing.endTime = DayDart.fromString(m['endTime']);
  return thing;
}

List<Thing> mapToThinglist(List<dynamic> l) {
  if (l.length == 0) {
    return [];
  }
  return l.map((u) => mapToThing(json.decode(u))).toList();
}

class Thing {
  String name;
  String type;
  int duration;
  DayDart startTime;
  DayDart endTime;

  Thing(this.name, this.type, this.duration);

  Thing.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        duration = int.parse(json['duration']),
        startTime = DayDart.fromString(json['startTime']),
        endTime = DayDart.fromString(json['endTime']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'duration': duration.toString(),
        'startTime': startTime.toString(),
        'endTime': endTime.toString()
      };
}

class ThingList {
  List<Thing> things;
  ThingList({this.things});
  // List<Thing> thingList = new List<Thing>();
  // thingList =
  factory ThingList.fromJson(List<dynamic> parsedJson) {
    List<Thing> things = new List<Thing>();
    things = parsedJson.map((i) => Thing.fromJson(i)).toList();
    return new ThingList(things: things);
  }
  Map<String, dynamic> toJson() =>
      {'things': things.map((u) => json.encode(u)).toList()};
}
