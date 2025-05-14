import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../widgets/bottom_navigation.dart';
import '../data/markerdata.dart';

class OfflineLocation extends StatefulWidget {
  final String accessToken;
  const OfflineLocation({super.key, required this.accessToken});

  @override
  State<OfflineLocation> createState() => _OfflineLocationState();
}

class _OfflineLocationState extends State<OfflineLocation> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(37.5665, 126.9780);
  Set<Marker> _markers = {};
  BitmapDescriptor? _customIcon, _goodwillIcon, _hmIcon, _arketIcon, _saIcon;
  StoreMarker? _selectedMarker;
  bool _isMarkersLoaded = false;

  @override
  void initState() {
    super.initState();
    _initMarkerData();
  }

  Future<void> _initMarkerData() async {
    await _getCurrentLocation();

    final icons = await Future.wait([
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(20, 20)),
          'assets/images/marker.png'),
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(40, 40)),
          'assets/images/goodwillmarker.png'),
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(40, 40)),
          'assets/images/hm_marker.png'),
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(40, 40)),
          'assets/images/arket_marker.png'),
      BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(40, 40)),
          'assets/images/sa_marker.png'),
    ]);

    _customIcon = icons[0];
    _goodwillIcon = icons[1];
    _hmIcon = icons[2];
    _arketIcon = icons[3];
    _saIcon = icons[4];

    _showAllMarkers();
    setState(() {
      _isMarkersLoaded = true;
    });
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted)
        return;
    }

    final locationData = await location.getLocation();
    if (locationData.latitude != null && locationData.longitude != null) {
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
      _mapController?.animateCamera(CameraUpdate.newLatLng(_currentPosition));
    }
  }

  Set<Marker> _createMarkers({
    required List<StoreMarker> stores,
    required BitmapDescriptor icon,
    required String prefix,
  }) {
    return stores.map((store) {
      return Marker(
        markerId: MarkerId('${prefix}_${store.id}'),
        position: store.position,
        infoWindow: InfoWindow(title: store.id),
        icon: icon,
        onTap: () {
          _zoomTo(store.position, 19);
          setState(() {
            _selectedMarker = store;
          });
        },
      );
    }).toSet();
  }

  void _showMarkers(
      List<StoreMarker> stores, BitmapDescriptor icon, String prefix) {
    setState(() {
      _markers = _createMarkers(stores: stores, icon: icon, prefix: prefix);
      _selectedMarker = null;
    });
    _zoomTo(_currentPosition, 11);
  }

  void _showAllMarkers() {
    setState(() {
      _markers.clear();
      _markers.addAll(_createMarkers(
          stores: markerData, icon: _customIcon!, prefix: 'custom'));
      _markers.addAll(_createMarkers(
          stores: goodwillMarkerData,
          icon: _goodwillIcon!,
          prefix: 'goodwill'));
      _markers.addAll(
          _createMarkers(stores: hmMarkerData, icon: _hmIcon!, prefix: 'hm'));
      _markers.addAll(_createMarkers(
          stores: akMarkerData, icon: _arketIcon!, prefix: 'arket'));
      _markers.addAll(
          _createMarkers(stores: saMarkerData, icon: _saIcon!, prefix: 'sa'));
      _selectedMarker = null;
    });
    _zoomTo(_currentPosition, 11);
  }

  void _zoomTo(LatLng target, double zoomLevel) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
          CameraPosition(target: target, zoom: zoomLevel)),
    );
  }

  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371; // km
    final double dLat = _degreeToRadian(end.latitude - start.latitude);
    final double dLng = _degreeToRadian(end.longitude - start.longitude);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreeToRadian(start.latitude)) *
            cos(_degreeToRadian(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreeToRadian(double degree) {
    return degree * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _currentPosition, zoom: 11),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: false,
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
          ),
          if (!_isMarkersLoaded)
            Container(
              color: Colors.white.withOpacity(0.7), // 배경 흐림 처리 (선택)
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          _buildStoreButtons(screenHeight, screenWidth),
          if (_selectedMarker != null)
            _buildInfoCard(screenHeight, screenWidth, _selectedMarker!),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        accessToken: widget.accessToken,
      ),
    );
  }

  Widget _buildStoreButtons(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.0814),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 30),
            _buildStoreButton('View All', Colors.white, _showAllMarkers,
                screenWidth * 0.8, screenHeight, Icons.remove_red_eye_outlined),
            _buildStoreButton(
                'Beautiful Store',
                const Color(0xff7067FF),
                () => _showMarkers(markerData, _customIcon!, 'custom'),
                screenWidth,
                screenHeight,
                Icons.storefront_outlined),
            _buildStoreButton(
                'Goodwill store',
                const Color(0xff34A853),
                () => _showMarkers(
                    goodwillMarkerData, _goodwillIcon!, 'goodwill'),
                screenWidth,
                screenHeight,
                Icons.storefront_outlined),
            _buildStoreButton(
                'H&M',
                const Color(0xffCD2523),
                () => _showMarkers(hmMarkerData, _hmIcon!, 'hm'),
                screenWidth * 0.7,
                screenHeight,
                Icons.storefront_outlined),
            _buildStoreButton(
                'Arket',
                Colors.white,
                () => _showMarkers(akMarkerData, _arketIcon!, 'arket'),
                screenWidth * 0.7,
                screenHeight,
                Icons.storefront_outlined),
            _buildStoreButton(
                'The Salvation Army',
                const Color(0xffF16767),
                () => _showMarkers(saMarkerData, _saIcon!, 'sa'),
                screenWidth * 1.2,
                screenHeight,
                Icons.storefront_outlined),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreButton(String label, Color color, VoidCallback onPressed,
      double width, double height, IconData icon) {
    return SizedBox(
      height: height * 0.044111,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor:
              color == Colors.white ? const Color(0xff303030) : Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
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

  Widget _buildInfoCard(
      double screenHeight, double screenWidth, StoreMarker marker) {
    final double distance =
        _calculateDistance(_currentPosition, marker.position);

    return Positioned(
      bottom: screenHeight * 0.0264,
      right: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(2, 2),
                blurRadius: 4)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(marker.id,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: screenHeight * 0.0233),
              Row(
                children: [
                  const Icon(Icons.location_on,
                      color: Color(0xff6C63FF), size: 30),
                  Text('${distance.toStringAsFixed(1)} km',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                ],
              ),
              SizedBox(height: screenHeight * 0.0133),
              Container(
                width: screenWidth * 0.3222,
                height: screenHeight * 0.0407,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: const Color(0xffE6E6E6)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('assets/images/nav_logo.png',
                        width: screenWidth * 0.0467),
                    const Text('Direction',
                        style:
                            TextStyle(color: Color(0xff6C63FF), fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
