import 'package:flutter/material.dart';
import 'package:recloset/screens/home.dart';
import 'package:recloset/screens/camera.dart';
import 'package:recloset/screens/offlineLocation.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  final String accessToken;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.accessToken,
  });

  void _onTabSelected(BuildContext context, int index) {
    if (index == currentIndex) return;

    Widget destination;
    switch (index) {
      case 0:
        destination = HomeScreen(accessToken: accessToken);
        break;
      case 1:
        destination = CameraScreen(accessToken: accessToken);
        break;
      case 2:
        destination = OfflineLocation(accessToken: accessToken);
        break;
      default:
        destination = HomeScreen(accessToken: accessToken);
    }

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      bottom: false,
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff7067FF),
              Color(0xffA982FE),
            ],
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          currentIndex: currentIndex,
          onTap: (index) => _onTabSelected(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined, size: 35),
              label: 'Camera',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on_sharp, size: 35),
              label: 'Location',
            ),
          ],
        ),
      ),
    );
  }
}
