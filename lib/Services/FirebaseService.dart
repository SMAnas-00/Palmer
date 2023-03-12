import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palmer/AdminControls/AdminDash.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/Screens/Login&Signup.dart';

class FirebaseService {
  Future<void> isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    final adminDoc = await FirebaseFirestore.instance
        .collection('app')
        .doc('Users')
        .collection('Signup')
        .doc(user?.uid)
        .get();
    if (user != null) {
      if (adminDoc.data()?['Role'] == 'admin') {
        Timer(
            const Duration(seconds: 2),
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminPanel())));
      } else {
        Timer(
            const Duration(seconds: 2),
            () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHome())));
      }
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenLoginSignup())));
    }
  }
}
