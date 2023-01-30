import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gql_sub/data_handler.dart';

// Subscription
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final subscriptionDocument = gql(r'''
    subscription NewDecideData {
      newDeviceData {
        deviceId
        data {
          temperature {
            type
            value
            timeStamp
          } 
          position {
            type
            timeStamp
            latitude
            longitude
          }
        }
      }
    }
    ''');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GraphQL Example"),
      ),
      body: Subscription(
          options: SubscriptionOptions(document: subscriptionDocument),
          builder: (result) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print(result);
            return ResultAccumulator.appendUniqueEntries(
                latest: result.data,
                builder: (context, {results}) =>
                    DataHandler(deviceData: result.data));
          }),
    );
  }
}
