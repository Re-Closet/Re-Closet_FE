import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../widgets/bottom_navigation.dart';
import '../data/markerdata.dart';
import 'dart:ui' as ui;

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

  //icon init
  BitmapDescriptor? _customIcon; // 커스텀 마커 아이콘
  BitmapDescriptor? _goodwillIcon;
  BitmapDescriptor? _hmIcon;
  BitmapDescriptor? _arketIcon;
  BitmapDescriptor? _saIcon;

  @override
  void initState() {
    super.initState();
    _initMarkerData();
  }

//show markers 함수
  void _showBSmarkers() {
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
      _markers.clear();
      _markers.addAll(customMarkers);
    });
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 11,
        ),
      ),
    );
  }

  void _showGWmarkers() {
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
      _markers.clear();
      _markers.addAll(customMarkers);
    });
  }

  void _showHMmarkers() {
    if (_hmIcon == null) return;

    final customMarkers = hmMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('hm_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _hmIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(customMarkers);
    });
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 11,
        ),
      ),
    );
  }

  void _showArkeTmarkers() {
    if (_arketIcon == null) return;

    final customMarkers = akMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('arket_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _arketIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(customMarkers);
    });
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 11,
        ),
      ),
    );
  }

  void _showSAmarkers() {
    if (_saIcon == null) return;

    final customMarkers = saMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('sa_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _saIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.clear();
      _markers.addAll(customMarkers);
    });
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: 11,
        ),
      ),
    );
  }

  void _showAllMarkers() {
    _setCustomMarkers();
    _setGoodwillMarkers();
    _setHmMarkers();
    _setarketMarkers();
    _setSAMarkers();
  }

  //first Init
  Future<void> _initMarkerData() async {
    await _getCurrentLocation(); // 위치 먼저

    //beautiful store icon
    _customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(78, 78)),
      'assets/images/marker.png',
    );

    //goodwillIcon
    _goodwillIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(78, 78)),
        'assets/images/goodwillmarker.png');

    //hmIcon
    _hmIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(78, 78)),
        'assets/images/hm_marker.png');

    _arketIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(78, 78)),
        'assets/images/arket_marker.png');

    _saIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(78, 78)),
        'assets/images/sa_marker.png');

    _setCustomMarkers(); // 마커 세팅
    _setGoodwillMarkers();
    _setHmMarkers();
    _setarketMarkers();
    _setSAMarkers();
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

  //Set Beautiful Store Marker
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

  //Set Goodwill Store Marker
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

  //Set H&M Marker
  void _setHmMarkers() {
    if (_hmIcon == null) return;

    final customMarkers = hmMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('hm_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _hmIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.addAll(customMarkers);
    });
  }

  //Set arket Marker
  void _setarketMarkers() {
    if (_hmIcon == null) return;

    final customMarkers = akMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('hm_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _arketIcon!,
        onTap: () => _zoomToLocation(position),
      );
    }).toSet();

    setState(() {
      _markers.addAll(customMarkers);
    });
  }

  void _setSAMarkers() {
    if (_saIcon == null) return;

    final customMarkers = saMarkerData.map((data) {
      final id = data['id'] as String;
      final position = data['position'] as LatLng;

      return Marker(
        markerId: MarkerId('sa_$id'),
        position: position,
        infoWindow: InfoWindow(title: id),
        icon: _saIcon!,
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

  //marker 클릭 시, zoom: 19
  void _zoomToFirstLocation(LatLng target) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: target,
          zoom: 11,
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
              zoom: 11,
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
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.0814),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  _buildStoreButton(
                    icon: Icons.remove_red_eye_outlined,
                    label: 'View All',
                    color: Colors.white,
                    onPressed: () => _showAllMarkers(),
                    screenWidth: screenWidth * 0.8,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildStoreButton(
                    icon: Icons.storefront_outlined,
                    label: 'Beautiful Store',
                    color: const Color(0xff7067FF),
                    onPressed: () => _showBSmarkers(),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildStoreButton(
                    icon: Icons.storefront_outlined,
                    label: 'Goodwill store',
                    color: const Color(0xff34A853),
                    onPressed: () => _showGWmarkers(),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildStoreButton(
                    icon: Icons.storefront_outlined,
                    label: 'H&M',
                    color: const Color(0xffCD2523),
                    onPressed: () => _showHMmarkers(),
                    screenWidth: screenWidth * 0.7,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildStoreButton(
                    icon: Icons.storefront_outlined,
                    label: 'Arket',
                    color: Colors.white,
                    onPressed: () => _showArkeTmarkers(),
                    screenWidth: screenWidth * 0.7,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _buildStoreButton(
                    icon: Icons.storefront_outlined,
                    label: 'The Salvation Army',
                    color: const Color(0xffF16767),
                    onPressed: () => _showSAmarkers(),
                    screenWidth: screenWidth * 1.2,
                    screenHeight: screenHeight,
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
          ),

          // Positioned(
          //   bottom: screenHeight * 0.0264,
          //   right: screenWidth * 0.02777,
          //   child: Container(
          //     width: screenWidth * 0.9,
          //     height: screenHeight * 0.35273573923,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.grey.withOpacity(0.5),
          //           offset: const Offset(2, 2),
          //           blurRadius: 4,
          //         )
          //       ],
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(20.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           const Text(
          //             '아름다운 가게 영등포점',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           SizedBox(
          //             height: screenHeight * 0.02328288707,
          //           ),
          //           const Row(
          //             children: [
          //               Icon(
          //                 Icons.location_on,
          //                 color: Color(0xff6C63FF),
          //                 size: 30,
          //               ),
          //               Text(
          //                 '1.2km',
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.grey,
          //                 ),
          //               )
          //             ],
          //           ),
          //           SizedBox(
          //             height: screenHeight * 0.01328288707,
          //           ),
          //           Container(
          //             width: screenWidth * 0.32222222222,
          //             height: screenHeight * 0.04074505238,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(15),
          //               border: Border.all(
          //                 width: 1,
          //                 color: const Color(0xffE6E6E6),
          //               ),
          //             ),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //               children: [
          //                 Image.asset(
          //                   'assets/images/nav_logo.png',
          //                   width: screenWidth * 0.04666666666,
          //                 ),
          //                 const Text(
          //                   'Direction',
          //                   style: TextStyle(
          //                     color: Color(0xff6C63FF),
          //                     fontSize: 16,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // 현재 내 위치로 이동
          Positioned(
            bottom: screenHeight * 0.1164,
            right: screenWidth * 0.02777,
            child: FloatingActionButton(
              onPressed: () {
                _zoomToLocation(_currentPosition);
              },
              child: const Icon(Icons.pin_drop),
            ),
          ),

          //초기 위치로 이동
          Positioned(
            bottom: screenHeight * 0.1864,
            right: screenWidth * 0.02777,
            child: FloatingActionButton(
              onPressed: () {
                _zoomToFirstLocation(_currentPosition);
              },
              child: const Icon(Icons.pin_drop_outlined),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2),
    );
  }

  Widget _buildStoreButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
    required double screenWidth,
    required double screenHeight,
    required IconData icon,
  }) {
    return SizedBox(
      width: screenWidth * 0.42,
      height: screenHeight * 0.044111,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor:
              color == Colors.white ? const Color(0xff303030) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
