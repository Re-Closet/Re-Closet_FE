import 'package:flutter/material.dart';
import 'package:recloset/custom_icon_icons.dart';
import 'package:recloset/screens/ai_result.dart';
import 'package:recloset/screens/home.dart';

import '../widgets/bottom_navigation.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  //toggle button
  bool isTopSelected = true;
  late AnimationController _toggleController;
  late Animation<double> _animation;

  //Camera Controller
  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();

    //Camera Controller
    _setupCameraController();

    //toggle button
    _toggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        CurvedAnimation(parent: _toggleController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    //Camera Controller
    cameraController?.dispose();

    //toggle button
    _toggleController.dispose();
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

// Toggle 위젯
  Widget _buildToggleButton(double screenWidth) {
    double toggleWidth = screenWidth * 0.475;
    double toggleHeight = screenWidth * 0.13125;

    return Center(
      child: Container(
        width: toggleWidth,
        height: toggleHeight,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xffF4ECFE),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.25),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment:
                  isTopSelected ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: toggleWidth / 2,
                height: toggleHeight - 8,
                decoration: BoxDecoration(
                  color: const Color(0xff8982fe),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 2),
                        blurRadius: 2,
                        color: Colors.black.withOpacity(0.25)),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTopSelected = true;
                        _toggleController.reverse();
                      });
                    },
                    child: Center(
                      child: Icon(
                        CustomIcon.fluent_mdl2_shirt, // 티셔츠 아이콘
                        color: isTopSelected
                            ? Colors.white
                            : const Color(0xff8982fe).withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isTopSelected = false;
                        _toggleController.forward();
                      });
                    },
                    child: Center(
                      child: Icon(
                        CustomIcon.iconoir_pants, // 바지 아이콘
                        color: isTopSelected
                            ? const Color(0xff8982fe).withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUI() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final buttonDiameter = screenWidth * 0.209375;
    final buttonInnerDiameter = screenWidth * 0.165625;

    final barHeight = screenWidth * 0.409375;
    final mbarHeight = screenWidth * 0.11875;
    final sbarHeight = screenWidth * 0.01875;

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
            CameraPreview(
              cameraController!,
            ),

            //overlay
            Positioned(
              top: 0,
              bottom: barHeight + sbarHeight,
              left: 0,
              right: 0,
              child: Image.asset(
                isTopSelected
                    ? 'assets/images/tshirt_overlay.png'
                    : 'assets/images/pants_overlay.png',
                width: screenWidth,
                fit: BoxFit.cover, // 화면에 꽉 차게, 남는 부분은 잘림
                alignment: Alignment.center, // 중앙 정렬
              ),
            ),

            Positioned(
              top: mbarHeight + 20,
              left: 0,
              right: 0,
              child: const Text(
                'Please take the picture \n with a white background.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

            //top bar >> mbarHeight
            Positioned(
              top: 0,
              child: Container(
                width: screenWidth,
                height: mbarHeight,
                decoration: const BoxDecoration(color: Color(0xffF4ECFE)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.clear_rounded,
                          size: 24,
                          color: Color(0xff746BFF),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Toggle Button
            Positioned(
              bottom: barHeight + sbarHeight + 20,
              left: 0,
              right: 0,
              child: _buildToggleButton(screenWidth),
            ),

            //sbar
            Positioned(
              bottom: barHeight,
              child: Container(
                width: screenWidth,
                height: sbarHeight,
                decoration: const BoxDecoration(color: Color(0xff8982FE)),
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AiResult()),
                  );
                },
                child: Container(
                  width: buttonDiameter,
                  height: buttonDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff8982FE),
                        Color(0xffF3D1FB),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.25))
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: buttonInnerDiameter,
                    height: buttonInnerDiameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.25))
                      ],
                    ),
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
