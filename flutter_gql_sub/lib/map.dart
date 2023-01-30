import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; //
import 'package:latlong2/latlong.dart';
import 'package:flutter_gql_sub/classes/position.dart';

class Map extends StatefulWidget {
  final Position position;
  const Map({Key? key, required this.position}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late MapController mapController;
  late LatLng _center;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    _center = LatLng(widget.position.latitude, widget.position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
            center: _center,
            zoom: 18,
            interactiveFlags: InteractiveFlag.all,
            onPositionChanged: (MapPosition position, bool hasGesture) {
              setState(() {
                _center = position.center!;
              });
            }),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: [
              Marker(
                  point: LatLng(
                      widget.position.latitude, widget.position.longitude),
                  builder: (context) =>
                      const Icon(Icons.circle, size: 15.0, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}
