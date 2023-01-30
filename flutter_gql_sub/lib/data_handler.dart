import 'package:flutter/material.dart';
import 'package:flutter_gql_sub/classes/position.dart';
import 'package:flutter_gql_sub/classes/temperature.dart';
import 'package:flutter_gql_sub/map.dart';
import 'package:flutter_gql_sub/temperature_card.dart';

class DataHandler extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final deviceData;

  const DataHandler({Key? key, required this.deviceData}) : super(key: key);

  Temperature extractTemperature() {
    var data = deviceData['newDeviceData']['data'][0]['temperature'];
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(data['timeStamp']));

    return Temperature(
        type: data['type'],
        value: data['value'].toString(),
        timestamp: dateTime);
  }

  Position extractPosition() {
    var data = deviceData['newDeviceData']['data'][0]['position'];
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(data['timeStamp']));

    return Position(
        type: data['type'],
        timestamp: dateTime,
        latitude: double.parse(data['latitude']),
        longitude: double.parse(data['longitude']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
                  "Device \"${deviceData['newDeviceData']['deviceId']}\" dashboard")),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 3.0),
              child: SizedBox(
                  height: 70,
                  child: TemperatureCard(temperature: extractTemperature())),
            )),
            Center(
              child: SizedBox(
                height: 525,
                child: Map(position: extractPosition()),
              ),
            )
          ],
        ));
  }
}
