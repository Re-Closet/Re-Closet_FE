// reward_detail.dart
import 'package:flutter/material.dart';
import 'package:recloset/screens/reward.dart';
import 'package:recloset/widgets/basic_lg_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../widgets/buildphoto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class Uploadreward extends StatefulWidget {
  const Uploadreward({super.key});

  @override
  State<Uploadreward> createState() => _UploadrewardState();
}

class _UploadrewardState extends State<Uploadreward> {
  List<bool> isSelected = [true, false];
  String? selectedSite;
  File? uploadedImage;

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

  //submit button 예외 처리
  void _handleButtonPressed(BuildContext context) {
    if (selectedSite != null && uploadedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RewardScreen()),
      );
    } else if (uploadedImage == null) {
      Fluttertoast.showToast(
        msg: "Please upload an image.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (selectedSite == null) {
      Fluttertoast.showToast(
          msg: "Please select a donation site.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

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
              BuildPhoto(
                onImageSelected: (File? image) {
                  setState(() {
                    uploadedImage = image;
                  });
                },
              ),
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
}
