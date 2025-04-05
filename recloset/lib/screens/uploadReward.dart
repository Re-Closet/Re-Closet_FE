// reward_detail.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recloset/widgets/basic_lg_button.dart';
import '../models/reward.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:recloset/screens/home.dart';

class Uploadreward extends StatefulWidget {
  const Uploadreward({super.key});

  @override
  State<Uploadreward> createState() => _UploadrewardState();
}

class _UploadrewardState extends State<Uploadreward> {
  List<bool> isSelected = [true, false];
  String? selectedSite;

  //이미지 업로드
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  //이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  List<String> get selectedSiteList =>
      isSelected[0] ? onlinedonationSiteList : offlinedonationSiteList;

  final List<String> onlinedonationSiteList = [
    'OTCAN',
    'NEW HOPE',
    'GOOD WILL STORE',
    'BEAUTIFUL STORE'
  ];

  final List<String> offlinedonationSiteList = [
    'GOOD WILL STORE',
    'BEAUTIFUL STORE',
    'ARKET',
    'THE SALVATION ARMY',
    'H&M'
  ];

  final List<String> type = [
    'online',
    'offline',
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Upload Image',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff979797),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05555),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                'Select your donation site',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              //Online / Offline 선택 토글 버튼
              ToggleButtons(
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                fillColor: const Color(0xff7067FF),
                borderRadius: BorderRadius.circular(32),
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index; // 하나만 선택 가능
                    }
                    selectedSite = null; // 선택 초기화
                  });
                },
                children: <Widget>[
                  SizedBox(
                    width: (screenWidth - screenWidth * 0.1222) / 2,
                    child: Center(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          color: isSelected[0]
                              ? Colors.white
                              : const Color(0xff2C2C2C),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: (screenWidth - screenWidth * 0.1222) / 2,
                    child: Center(
                      child: Text(
                        'Offline',
                        style: TextStyle(
                          color: isSelected[1]
                              ? Colors.white
                              : const Color(0xff2C2C2C),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              //DropDown Location Site
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Color(0xffCCCCCC), // 비활성 상태일 때 테두리 색
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Color(0xff7067FF), // 포커스(클릭)됐을 때 테두리 색
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(
                      color: Colors.red, // 에러 발생 시 테두리 색
                      width: 1.5,
                    ),
                  ),
                ),
                hint: const Text(
                  'Select a site',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                items: selectedSiteList
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: selectedSite == item
                                  ? const Color(0xff7067FF)
                                  : Colors.black,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedSite,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a donation site.';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    selectedSite = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  height: screenHeight * 0.02910,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.03888),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white,
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: screenHeight * 0.05820,
                ),
              ),
              SizedBox(height: screenHeight * 0.06492),
              const Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildPhotoArea(),
              SizedBox(height: screenHeight * 0.03492),
              BasicLgButton(
                textColor: Colors.white,
                width: screenWidth * 0.8888,
                height: screenHeight * 0.0673,
                onPressed: () => _handleButtonPressed(context),
                text: 'Submit',
                color: const Color(0xff7067FF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoArea() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return _image != null
        ? GestureDetector(
            onTap: () => getImage(ImageSource.gallery),
            child: Container(
              width: screenWidth - screenWidth * 0.1222,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(2, 2), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.file(
                  File(_image!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: () => getImage(ImageSource.gallery),
            child: DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [8, 4],
              strokeWidth: 2,
              radius: const Radius.circular(21),
              color: const Color(0xff7067FF),
              child: SizedBox(
                width: screenWidth * 0.8888,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.ios_share_rounded,
                        size: 50,
                        color: Color(0xff746BFF),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Upload your files here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff6D747D),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Browse',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff6C63FF),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 1,
                        width: screenWidth * 0.128,
                        color: const Color(0xff746BFF),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  void _handleButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}
