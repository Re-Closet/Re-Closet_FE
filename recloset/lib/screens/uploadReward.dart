import 'package:flutter/material.dart';
import 'package:recloset/screens/rewardscreen.dart';
import 'package:recloset/widgets/basic_lg_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../widgets/buildphoto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class Uploadreward extends StatefulWidget {
  final String accessToken;

  const Uploadreward({super.key, required this.accessToken});

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

  void _handleButtonPressed(BuildContext context) async {
    if (selectedSite != null && uploadedImage != null) {
      try {
        final uri = Uri.parse(
            'https://recloset-114997745103.asia-northeast3.run.app/rewards/request');
        final request = http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer ${widget.accessToken}'
          ..headers['accept'] = '*/*'
          ..fields['donationSite'] = selectedSite!
          ..files.add(await http.MultipartFile.fromPath(
            'donationPhoto',
            uploadedImage!.path,
            filename: basename(uploadedImage!.path),
          ));
        print("Token Being Sent: ${request.headers['Authorization']}");

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        debugPrint('Status code: ${response.statusCode}');
        debugPrint('Response headers: ${response.headers}');
        debugPrint('Response body: $responseBody');

        if (response.statusCode == 200) {
          final Map<String, dynamic> parsed = jsonDecode(responseBody);
          final message = parsed['message'] ?? "Upload successful!";
          Fluttertoast.showToast(msg: message);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RewardScreen(
                accessToken: widget.accessToken,
              ),
            ),
          );
        } else if (response.statusCode == 302) {
          final redirectUrl = response.headers['location'];
          debugPrint('Redirected to: $redirectUrl');
          Fluttertoast.showToast(
            msg: "Redirected to: $redirectUrl",
            toastLength: Toast.LENGTH_LONG,
          );

          if (redirectUrl != null &&
              await canLaunchUrl(Uri.parse(redirectUrl))) {
            await launchUrl(Uri.parse(redirectUrl));
          }
        } else {
          Fluttertoast.showToast(
            msg: "Upload failed. Status: ${response.statusCode}",
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Upload error: $e",
          toastLength: Toast.LENGTH_LONG,
        );
      }
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
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xff979797)),
          onPressed: () => Navigator.pop(context),
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
              ToggleButtons(
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                fillColor: const Color(0xff7067FF),
                borderRadius: BorderRadius.circular(32),
                isSelected: isSelected,
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                    selectedSite = null;
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
                          fontSize: 14,
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
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField2<String>(
                isExpanded: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide:
                        const BorderSide(color: Color(0xffCCCCCC), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide:
                        const BorderSide(color: Color(0xff7067FF), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: const BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
                hint: const Text(
                  'Select a site',
                  style: TextStyle(fontSize: 15, color: Colors.black),
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
                validator: (value) =>
                    value == null ? 'Please select a donation site.' : null,
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
