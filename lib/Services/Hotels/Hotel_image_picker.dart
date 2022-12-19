import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HotelImagePicker extends StatefulWidget {
  const HotelImagePicker({super.key});

  @override
  State<HotelImagePicker> createState() => _HotelImagePickerState();
}

class _HotelImagePickerState extends State<HotelImagePicker> {
  File? _image;
  final picker = ImagePicker();

  Future imagePicker() async {
    final pick = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      }
    });
  }

  Future uploadImage(File _image) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('app').child('/images');
    ref.putFile(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
