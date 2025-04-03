import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../widgets/bottom_navigation.dart';
import '../data/markerdata.dart';

class OfflineLocation extends StatefulWidget {
  const OfflineLocation({super.key});

  @override
  State<OfflineLocation> createState() => _OfflineLocationState();
}

class _OfflineLocationState extends State<OfflineLocation> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(37.5665, 126.9780); // 기본값: 서울 시청
  bool _isLocationLoaded = false;
  final Set<Marker> _markers = {}; // 마커 모음
  BitmapDescriptor? _customIcon; // 커스텀 마커 아이콘
  BitmapDescriptor? _goodwillIcon;
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
    _goodwillIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(78, 78)),
        'assets/images/goodwillmarker.png');
    _setCustomMarkers(); // 마커 세팅
    _setGoodwillMarkers();
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

  //아름다운 가게 Marker
  void _setCustomMarkers() {
    if (_customIcon == null) return;

    final customMarkers = markerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('custom_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _customIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.addAll(customMarkers);
    });
  }

  //Goodwill Store Marker
  void _setGoodwillMarkers() {
    if (_goodwillIcon == null) return;

    final customMarkers = goodwillMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('goodwill_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _goodwillIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.addAll(customMarkers);
    });
  }

//marker 클릭 시, zoom: 19
  void _zoomToLocation(LatLng target) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: 19,
        ),
      ),
    );
  }

  //UI 구성
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
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

          Positioned(
            top: screenHeight * 0.0814,
            left: screenWidth * 0.04444,
            child: SizedBox(
              width: screenWidth * 0.4888,
              height: screenHeight * 0.044111,
              child: ElevatedButton(
                onPressed: () {
                  _zoomToLocation(_currentPosition);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.storefront, size: 20),
                    SizedBox(width: 8),
                    Text('Beautiful Store'),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.0814,
            left: screenWidth * 0.4888 + screenWidth * 0.08,
            child: SizedBox(
              width: screenWidth * 0.4888,
              height: screenHeight * 0.044111,
              child: ElevatedButton(
                onPressed: () {
                  _zoomToLocation(_currentPosition);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 5,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.storefront, size: 20),
                    SizedBox(width: 8),
                    Text('Goodwill store'),
                  ],
                ),
              ),
            ),
          ),

          // 현재 내 위치로 이동
          Positioned(
            bottom: screenHeight * 0.1164,
            right: screenWidth * 0.02777,
            child: FloatingActionButton(
              onPressed: () {
                _zoomToLocation(_currentPosition);
              },
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
