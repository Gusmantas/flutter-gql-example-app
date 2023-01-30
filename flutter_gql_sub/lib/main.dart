import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_gql_sub/pages/home.dart';

void main() async {
  await initHiveForFlutter();
  final HttpLink httpLink =
      HttpLink("https://petsaurus-graphql-api.azurewebsites.net/graphql");

  final WebSocketLink websocketLink = WebSocketLink(
    "wss://petsaurus-graphql-api.azurewebsites.net/subscriptions",
    config: const SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: Duration(seconds: 30),
    ),
  );

  final Link link =
      Link.split((request) => request.isSubscription, websocketLink, httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(GraphQLProvider(
    client: client,
    child: MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    ),
  ));
}

// Query Example

class QueryTest extends StatelessWidget {
  QueryTest({Key? key}) : super(key: key);

  final readDocument = gql(r"""
  query DeviceData {
  deviceData {
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
""");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Query Test")),
      body: Query(
          options: QueryOptions(document: readDocument),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Text('Loading');
            }
            return Text(result.data.toString());
          }),
    );
  }
}
