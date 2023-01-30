import 'package:flutter/material.dart';
import 'package:flutter_gql_sub/classes/temperature.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TemperatureCard extends StatelessWidget {
  Temperature temperature;
  TemperatureCard({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.device_thermostat,
                size: 35,
              ),
              Text(
                temperature.value,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.schedule, size: 35),
              Text(
                DateFormat('hh:mm:ss').format(temperature.timestamp),
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.calendar_month, size: 35),
              Text(
                DateFormat('yyyy-MM-dd').format(temperature.timestamp),
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ],
      ),
    );
  }
}
