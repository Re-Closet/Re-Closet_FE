import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';

import 'package:recloset/custom_icon_icons.dart';
import 'package:recloset/screens/ai_result.dart';
import 'package:recloset/screens/home.dart';

class CameraScreen extends StatefulWidget {
  final String accessToken;
  const CameraScreen({super.key, required this.accessToken});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  bool isTopSelected = true;
  late AnimationController _toggleController;
  late Animation<double> _animation;
  bool _isAnalyzing = false;

  List<CameraDescription> cameras = [];
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    _setupCameraController();
    _toggleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation =
        CurvedAnimation(parent: _toggleController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    cameraController?.dispose();
    _toggleController.dispose();
    super.dispose();
  }

  Future<void> _setupCameraController() async {
    try {
      List<CameraDescription> cameraList = await availableCameras();
      final backCamera = cameraList.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameraList.first,
      );

      cameraController = CameraController(
        backCamera,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
        enableAudio: false,
      );

      await cameraController!.initialize();
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) setState(() {});
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('카메라 오류'),
          content: Text('카메라 초기화 실패: $e'),
        ),
      );
    }
  }

  Future<void> analyzeImage(File imageFile) async {
    setState(() {
      _isAnalyzing = true;
    });

    try {
      final uri = Uri.parse(
          'https://recloset-114997745103.asia-northeast3.run.app/api/image/analyze');

      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${widget.accessToken}'
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse['data'];
        final responseData = data['response_data'] ?? {};

        if (!mounted) return;
        final rawConfidence = data['confidence'];
        final confidence =
            (rawConfidence is num) ? rawConfidence.toDouble() : 0.0;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AiResult(
              response: responseData['response'] ?? '',
              solution: responseData['solution'] ?? '',
              confidence: confidence,
              prediction: data['prediction'] ?? '',
              resultType: data['resultType'] ?? false,
              rawJson: jsonResponse, // 정상일 때도 전달
            ),
          ),
        );
      } else {
        // 서버 에러 응답 디버깅용
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AiResult(
              response: 'Error',
              solution: '',
              confidence: 0.0,
              prediction: '',
              resultType: false,
              rawJson: {
                'statusCode': response.statusCode,
                'body': response.body,
              },
            ),
          ),
        );
      }
    } catch (e) {
      // 네트워크 에러 등 디버깅용
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AiResult(
            response: 'Exception',
            solution: '',
            confidence: 0.0,
            prediction: '',
            resultType: false,
            rawJson: {
              'error': e.toString(),
            },
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

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
                        CustomIcon.fluent_mdl2_shirt,
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
                        CustomIcon.iconoir_pants,
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

    final buttonDiameter = screenWidth * 0.209375;
    final buttonInnerDiameter = screenWidth * 0.165625;

    final barHeight = screenWidth * 0.409375;
    final mbarHeight = screenWidth * 0.11875;
    final sbarHeight = screenWidth * 0.01875;

    if (cameraController == null ||
        cameraController?.value.isInitialized == false) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox(
              width: 400,
              height: 650,
              child: Image.asset(
                'assets/images/tshirt.png',
                fit: BoxFit.fitWidth, // center crop 효과
              ),
            ),

            CameraPreview(cameraController!),

            if (_isAnalyzing)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),

            // Overlay
            Positioned(
              top: 0,
              bottom: barHeight + sbarHeight,
              left: 0,
              right: 0,
              child: Image.asset(
                isTopSelected
                    ? 'assets/images/tshirt_overlay.png'
                    : 'assets/images/pants_overlay.png',
                fit: BoxFit.cover,
              ),
            ),

            // 안내 문구
            Positioned(
              top: mbarHeight + 10,
              left: 0,
              right: 0,
              child: const Text(
                'Please take the picture \n with a white background.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            // 상단 바
            Positioned(
              top: 0,
              child: Container(
                width: screenWidth,
                height: mbarHeight,
                decoration: const BoxDecoration(color: Colors.white),
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
                              builder: (context) => HomeScreen(
                                accessToken: widget.accessToken,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Toggle 버튼
            Positioned(
              bottom: barHeight + sbarHeight + 20,
              left: 0,
              right: 0,
              child: _buildToggleButton(screenWidth),
            ),

            // 구분 바
            Positioned(
              bottom: barHeight,
              child: Container(
                width: screenWidth,
                height: sbarHeight,
                color: const Color(0xff8982FE),
              ),
            ),

            // 하단 영역
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                height: barHeight,
                width: screenWidth,
                color: Colors.white,
              ),
            ),

            // 카메라 촬영 버튼
            Positioned(
              left: screenWidth / 2 - buttonDiameter / 2,
              bottom: barHeight / 2 - buttonDiameter / 2,
              child: GestureDetector(
                onTap: () async {
                  if (cameraController == null ||
                      !cameraController!.value.isInitialized) return;

                  setState(() {
                    _isAnalyzing = true;
                  });

                  try {
                    final XFile image = await cameraController!.takePicture();
                    await analyzeImage(File(image.path));
                  } catch (e) {
                    print('촬영 중 오류 발생: $e');
                    setState(() {
                      _isAnalyzing = false;
                    });
                  }
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
            ),

            // 갤러리 버튼
            Positioned(
              left: 50,
              bottom: barHeight / 2 - 20,
              child: GestureDetector(
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    await analyzeImage(File(image.path));
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff8982FE),
                  ),
                  child: const Icon(
                    Icons.photo_library_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildUI(),
    );
  }
}
