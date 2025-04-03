import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../widgets/bottom_navigation.dart';

class OfflineLocation extends StatefulWidget {
  const OfflineLocation({super.key});

  @override
  State<OfflineLocation> createState() => _OfflineLocationState();
}

class _OfflineLocationState extends State<OfflineLocation> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(37.5665, 126.9780); // 기본값: 서울 시청
  bool _isLocationLoaded = false;

  Future<void> _getCurrentLocation() async {
    Location location = Location();

    // 권한 요청 및 위치 활성화
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
        _isLocationLoaded = true;
      });

      // 카메라 이동
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_currentPosition),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition,
          zoom: 17,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
          if (_isLocationLoaded) {
            _mapController!.animateCamera(
              CameraUpdate.newLatLng(_currentPosition),
            );
          }
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
