import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carmen Sandiego',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Onde Está Carmen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Marker> _pontos = [];
  double _zomm = 6;

  @override
  void initState() {
    super.initState();
    _exiberMapa(_pontos, _zomm);
  }

  Widget _exiberMapa(List<Marker> _pontos, _zomm) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(-8.4121861, -38.9033043),
        zoom: _zomm,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayerOptions(
          markers: _pontos,
        ),
        PolylineLayerOptions(
            polylineCulling: false,
            polylines: [
                Polyline(
                  points: [LatLng(-8.4121861, -38.9033043), LatLng(-8.5421001,-37.0922099), LatLng(-8.3675989,-37.5671426),],
                  color: Colors.blue,
                ),
            ],
        ),
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'JJunio',
          onSourceTapped: null,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      child: _exiberMapa(_pontos, _zomm),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pontos.add(
                        Marker(
                          point: LatLng(-8.4121861, -38.9033043),
                          width: 80,
                          height: 80,
                          builder: (context) =>
                              const Icon(Icons.pin_drop),
                        ),
                      );
                      _pontos.add(
                        Marker(
                          point: LatLng(-8.5421001,-37.0922099),
                          width: 80,
                          height: 80,
                          builder: (context) =>
                              const Icon(Icons.pin_drop),
                        ),
                      );
                      _pontos.add(
                        Marker(
                          point: LatLng(-8.3675989,-37.5671426),
                          width: 80,
                          height: 80,
                          builder: (context) =>
                              const Icon(Icons.pin_drop),
                        ),
                      );
                      _pontos.add(
                        Marker(
                          point: LatLng(-8.3141311,-38.0768195),
                          width: 80,
                          height: 80,
                          builder: (context) =>
                              const Icon(Icons.pin_drop),
                        ),
                      );
                      _zomm = 10.0;
                      _exiberMapa(_pontos, _zomm);
                    });
                  },
                  child: const Text('Get Location?')),
            ),
          ],
        ),
      ),
    );
  }
}
