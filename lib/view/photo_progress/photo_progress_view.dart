import 'dart:convert';
import 'dart:io';
import 'package:fitness/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/colo_extension.dart';

class PhotoProgressView extends StatefulWidget {
  const PhotoProgressView({super.key});

  @override
  State<PhotoProgressView> createState() => _PhotoProgressViewState();
}

class _PhotoProgressViewState extends State<PhotoProgressView> {
  List<Map<String, dynamic>> photoArr = [];

  @override
  void initState() {
    super.initState();
    _loadPhotoList(); // Load photo list from SharedPreferences when the widget is initialized.
  }

  // Load the stored list from SharedPreferences
  Future<void> _loadPhotoList() async {
    String? photoListStr = prefs.getString('photo_list');

    if (photoListStr != null) {
      List<dynamic> jsonData = json.decode(photoListStr);
      setState(() {
        photoArr = List<Map<String, dynamic>>.from(jsonData);
      });
    }
  }

  // Save the updated list to SharedPreferences
  Future<void> _savePhotoList() async {
    String jsonData = json.encode(photoArr);
    await prefs.setString('photo_list', jsonData);
  }

  // Add a new photo to the list
  Future<void> _addPhoto(File imageFile) async {
    String currentDate = _getCurrentDate();
    Map<String, dynamic> newEntry = {
      "time": currentDate,
      "photo": [imageFile.path]
    };

    setState(() {
      photoArr.add(newEntry);
    });

    await _savePhotoList(); // Save the updated list after adding a new photo.
  }

  // Function to get the current date in the required format
  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)}";
  }

  // Helper function to get month name
  String _getMonthName(int monthNumber) {
    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[monthNumber - 1];
  }

  // Function to open the camera and take a photo
  Future<void> _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _addPhoto(
          imageFile); // Add the photo to the list and save to SharedPreferences.
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        leading: const SizedBox(),
        title: Text(
          "Progress Photo",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Gallery",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: photoArr.length,
                itemBuilder: ((context, index) {
                  var pObj = photoArr[index] as Map? ?? {};
                  var imaArr = pObj["photo"] as List? ?? [];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pObj["time"].toString(),
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.zero,
                          itemCount: imaArr.length,
                          itemBuilder: ((context, indexRow) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 100,
                              decoration: BoxDecoration(
                                color: TColor.lightGray,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imaArr[indexRow]),
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
                })),
            SizedBox(
              height: media.width * 0.05,
            ),
          ],
        ),
      ),
      floatingActionButton: InkWell(
        onTap: _openCamera,
        child: Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: TColor.secondaryG),
              borderRadius: BorderRadius.circular(27.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, 2))
              ]),
          alignment: Alignment.center,
          child: Icon(
            Icons.photo_camera,
            size: 20,
            color: TColor.white,
          ),
        ),
      ),
    );
  }
}
