import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kasambahayko/src/constants/colors.dart';
import 'package:kasambahayko/src/controllers/auth_controllers/user_info_controller.dart';

class ProfileImagePicker extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ProfileImagePicker({super.key, required this.onImageSelected});

  @override
  ProfilePickerState createState() => ProfilePickerState();
}

class ProfilePickerState extends State<ProfileImagePicker> {
  File? image;

  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      widget.onImageSelected(image);
    }
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      widget.onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<UserInfoController>().userInfo;
    final imageUrl = userInfo['imageUrl']?.toString();
    ImageProvider? backgroundImage;

    if (image != null) {
      backgroundImage = FileImage(image!);
    } else if (imageUrl != null) {
      backgroundImage = NetworkImage(imageUrl);
    }

    return Column(
      children: <Widget>[
        Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: primarycolor,
              backgroundImage: backgroundImage,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showImagePickerDialog();
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: primarycolor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option:"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromCamera();
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                getImageFromGallery();
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }
}
