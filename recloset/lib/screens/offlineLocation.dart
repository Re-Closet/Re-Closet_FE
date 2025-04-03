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
  Set<Marker> _markers = {}; // 마커 모음
  BitmapDescriptor? _customIcon; // 커스텀 마커 아이콘

  @override
  void initState() {
    super.initState();
    _initMarkerData();
  }

  Future<void> _initMarkerData() async {
    await _getCurrentLocation(); // 위치 먼저
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(78, 78)),
      'assets/images/marker.png',
    );
    _setCustomMarkers(); // 마커 세팅
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();

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

      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_currentPosition),
      );
    }
  }

  void _setCustomMarkers() {
    if (_customIcon == null) return;

    setState(() {
      _markers = {
        Marker(
          markerId: const MarkerId('아름다운가게 관악자명점'),
          position: const LatLng(37.484608, 126.9373154),
          infoWindow: const InfoWindow(title: '아름다운가게 관악자명점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 남성역점'),
          position: const LatLng(37.4831831, 126.9755662),
          infoWindow: const InfoWindow(title: '아름다운가게 남성역점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운 가게 영등포점'),
          position: const LatLng(37.5190968, 126.9059359),
          infoWindow: const InfoWindow(title: '아름다운 가게 영등포점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 서초점'),
          position: const LatLng(37.4930764, 127.0176044),
          infoWindow: const InfoWindow(title: '아름다운가게 서초점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 숙대입구점'),
          position: const LatLng(37.5431183, 126.9728513),
          infoWindow: const InfoWindow(title: '아름다운가게 숙대입구점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 안국점'),
          position: const LatLng(37.5788203, 126.9849592),
          infoWindow: const InfoWindow(title: '아름다운가게 안국점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 망원역점'),
          position: const LatLng(37.5553083, 126.9101247),
          infoWindow: const InfoWindow(title: '아름다운가게 망원역점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 개봉점'),
          position: const LatLng(37.4970413, 126.8572128),
          infoWindow: const InfoWindow(title: '아름다운가게 개봉점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 강남구청역점'),
          position: const LatLng(37.5163937, 127.0378848),
          infoWindow: const InfoWindow(title: '아름다운가게 강남구청역점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 압구정점'),
          position: const LatLng(37.5273895, 127.030957),
          infoWindow: const InfoWindow(title: '아름다운가게 압구정점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 목동점'),
          position: const LatLng(37.5367306, 126.8822117),
          infoWindow: const InfoWindow(title: '아름다운가게 목동점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 삼선교점'),
          position: const LatLng(37.5885305, 127.0055957),
          infoWindow: const InfoWindow(title: '아름다운가게 삼선교점'),
          icon: _customIcon!,
        ),
        Marker(
          markerId: const MarkerId('아름다운가게 광진화양점'),
          position: const LatLng(37.548551, 127.068139),
          infoWindow: const InfoWindow(title: '아름다운가게 광진화양점'),
          icon: _customIcon!,
        ),
      };
    });
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
        markers: _markers,
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
