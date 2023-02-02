import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SendLocationMapScreen extends StatefulWidget {
  const SendLocationMapScreen({super.key});

  @override
  State<SendLocationMapScreen> createState() => _SendLocationMapScreenState();
}

class _SendLocationMapScreenState extends State<SendLocationMapScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(36.103422, 129.389222);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            '위치 공유하기',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 17.0,
          ),
        ),
      ),
    );
  }
}
