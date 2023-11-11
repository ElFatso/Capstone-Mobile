import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:kasambahayko/src/constants/colors.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImageSelected;

  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  ImagePickerWidgetState createState() => ImagePickerWidgetState();
}

class ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? image;

  Future _getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
      widget.onImageSelected(image);
    }
  }

  Future _getImageFromGallery() async {
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
    return Column(
      children: <Widget>[
        Stack(
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: primarycolor,
              child: image == null
                  ? const Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Color(0xFFFAFAFA),
                    )
                  : CircleAvatar(
                      backgroundImage: image != null ? FileImage(image!) : null,
                      radius: 75,
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  _showImagePickerDialog();
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: primarycolor, // Set the icon color to primarycolor
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose an option:"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getImageFromCamera();
              },
              child: const Text("Camera"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _getImageFromGallery();
              },
              child: const Text("Gallery"),
            ),
          ],
        );
      },
    );
  }
}
