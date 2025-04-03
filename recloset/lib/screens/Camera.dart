import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('📷 Camera Page')),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 1),
    );
  }
}
