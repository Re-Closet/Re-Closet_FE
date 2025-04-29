import 'package:flutter/material.dart';
import '../widgets/bottom_navigation.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    _setupCameraController();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<void> _setupCameraController() async {
    List<CameraDescription> cameraList = await availableCameras();
    if (cameraList.isNotEmpty) {
      cameraController = CameraController(
        cameraList.first,
        ResolutionPreset.high,
      );
      await cameraController!.initialize();
      setState(() {
        cameras = cameraList;
      });
    }
  }

  Widget _buildUI() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonDiameter = screenWidth * 0.209375;
    final buttonInnerDiameter = screenWidth * 0.165625;

    final barHeight = screenHeight * 0.15599534342;

    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SafeArea(
      child: SizedBox.expand(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/tshirt_overlay.png',
              width: screenWidth,
              height: screenHeight,
            ),
            CameraPreview(
              cameraController!,
            ),

            Positioned(
              top: 0,
              child: Container(
                width: screenWidth,
                height: screenWidth * 0.11875,
                decoration: const BoxDecoration(color: Color(0xffF4ECFE)),
              ),
            ),
            Positioned(
              bottom: barHeight,
              child: Container(
                width: screenWidth,
                height: screenWidth * 0.11875,
                decoration: const BoxDecoration(color: Color(0xffF4ECFE)),
              ),
            ),

            //bottom Container
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: barHeight,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),

            //botton button layout - gradient
            Positioned(
              left: screenWidth / 2 - buttonDiameter / 2,
              bottom: barHeight / 2 - buttonDiameter / 2,
              child: Container(
                width: buttonDiameter,
                height: buttonDiameter,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff8982FE),
                      Color(0xffF3D1FB),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: buttonInnerDiameter,
                  height: buttonInnerDiameter,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }
}
