import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

class BuildPhoto extends StatefulWidget {
  final Function(File?) onImageSelected;
  const BuildPhoto({super.key, required this.onImageSelected});

  @override
  State<StatefulWidget> createState() => _BuildPhotoState();
}

class _BuildPhotoState extends State<BuildPhoto> {
  File? _image;

  Future<void> getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      widget.onImageSelected(_image); // 콜백 실행
    }
  }

  Widget _buildPhotoArea() {
    double screenWidth = MediaQuery.of(context).size.width;

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
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: Image.file(
                  _image!,
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
                      const SizedBox(height: 10),
                      const Text(
                        'Upload your files here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff6D747D),
                        ),
                      ),
                      const SizedBox(height: 10),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildPhotoArea(),
    );
  }
}
