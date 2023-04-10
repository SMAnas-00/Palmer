// ignore_for_file: prefer_const_constructors, file_names, camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:palmer/main.dart';
import '../addons/round_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class account_Page extends StatefulWidget {
  const account_Page({super.key});

  @override
  State<account_Page> createState() => _account_PageState();
}

class _account_PageState extends State<account_Page> {
  File? image;
  final picker = ImagePicker();
  String imageUrl = ' ';
  String username = "";

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final cnicController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    fnameController.dispose();
    lnameController.dispose();
    addressController.dispose();
  }

  Future<void> setProfile() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    final user = auth.currentUser;
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/profiledp/${DateTime.now().millisecondsSinceEpoch}');
    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
      firestore
          .collection("app")
          .doc("Users")
          .collection("Signup")
          .doc(user?.uid)
          .update({'dp': imageUrl.toString()});
      displayMessage("Profile uploaded successfully");
    }).onError((error, stackTrace) {
      displayMessage(error.toString());
    });
  }

  Future<String> getProfileImage() async {
    final uid = auth.currentUser?.uid;
    final users = await firestore
        .collection("app")
        .doc("Users")
        .collection("Signup")
        .doc(uid)
        .get();
    return users.data()?['dp'];
  }

  Future updateuserData() async {
    final uid = auth.currentUser?.uid;
    final user =
        firestore.collection('app').doc('Users').collection('Signup').doc(uid);
    if (phoneController.text.isNotEmpty) {
      user.update({'phone': phoneController.text});
    }
    if (fnameController.text.isNotEmpty) {
      user.update({'First_name': fnameController.text});
    }
    if (lnameController.text.isNotEmpty) {
      user.update({'Last_name': lnameController.text});
    }
    if (addressController.text.isNotEmpty) {
      user.update({'Address': addressController.text});
    }
    if (cnicController.text.isNotEmpty) {
      user.update({'CNIC': cnicController.text});
      print(cnicController);
    }
    displayMessage("Profile Updated successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[300],
          automaticallyImplyLeading: false,
          title: const Text("Profile"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.teal[300],
                            borderRadius: BorderRadius.circular(100.0)),
                        child: FutureBuilder(
                          future: getProfileImage(),
                          builder: (_, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircleAvatar(
                                backgroundColor: Colors.teal[300],
                              );
                            }
                            return Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.teal[300],
                                    borderRadius: BorderRadius.circular(100)),
                                child: snapshot.data == ""
                                    ? ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(48.0),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.teal[300],
                                          ),
                                        ),
                                      )
                                    : ClipOval(
                                        child: SizedBox.fromSize(
                                            size: const Size.fromRadius(48.0),
                                            child: Image.network(
                                                snapshot.data.toString())),
                                      ));
                          },
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
                              setProfile();
                            },
                            elevation: 2.0,
                            fillColor: Colors.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.teal,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                StreamBuilder(
                  stream: firestore
                      .collection("app")
                      .doc("Users")
                      .collection("Signup")
                      .doc(auth.currentUser?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: snapshot.data?['Email'],
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 17.0),
                              suffixIcon: const Icon(
                                Icons.email,
                                size: 20,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: snapshot.data?['Contact'],
                              hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 21, 21, 21),
                              ),
                              suffixIcon: const Icon(
                                Icons.phone,
                                size: 20,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: fnameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: snapshot.data?['First_name'],
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 21, 21, 21)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: lnameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: snapshot.data?['Last_name'],
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 21, 21, 21)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: addressController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: snapshot.data?['Address'],
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 21, 21, 21)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            controller: cnicController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              hintText: (snapshot.data! == null &&
                                      snapshot.data!
                                          .data()!
                                          .containsKey('cnic'))
                                  ? snapshot.data!['cnic']
                                  : 'CNIC',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 21, 21, 21)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal[300],
                              fixedSize: Size(150, 30)),
                          child: Text("Save"),
                          onPressed: () {
                            updateuserData();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
