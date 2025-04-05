// reward_detail.dart
import 'package:flutter/material.dart';
import '../models/reward.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';

class Uploadreward extends StatefulWidget {
  const Uploadreward({super.key});

  @override
  State<Uploadreward> createState() => _UploadrewardState();
}

class _UploadrewardState extends State<Uploadreward> {
  List<bool> isSelected = [true, false];
  String? selectedSite;

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.165),
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.165),
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
              ],
            ),
            const SizedBox(height: 20),

            //DropDown Location Site
            DropdownButtonFormField2<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
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
                          style: const TextStyle(
                            fontSize: 14,
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
            const SizedBox(height: 30),
            const Text(
              'Upload Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
