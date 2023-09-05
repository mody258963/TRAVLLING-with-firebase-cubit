import 'dart:ffi';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'dart:async';
import 'package:csc_picker/csc_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;


import 'dart:convert';

import 'package:traelling_app/prestation_layer/widgets/globle.dart';

class Addingpage extends StatefulWidget {
  const Addingpage({super.key});

  @override
  State<Addingpage> createState() => _AddingpageState();
}

class _AddingpageState extends State<Addingpage> {
  final location = TextEditingController();
  final detals = TextEditingController();
  final expectedprice = TextEditingController();
  final expectedrent = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("post")
        .child(fAuth.currentUser!.uid);
  var imageUrl = '';
  final ImagePicker imagePicker = ImagePicker();
  PickedFile? file;
  String? uuid = " ";
  List<File>? images = [];
  

  Future<void> addUser() {
    return ref.child('post').set({
      "uuid": FirebaseAuth.instance.currentUser?.uid,
      "location": location.text, // John Doe
      "detals": detals.text, // Stokes and Sons
      "phone number": expectedprice.text,
      "expectedrent": expectedrent.text,
      "image": images

      // "proparty id" :
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  

  List<String> downloadUrls = [];

  final ImagePicker _picker = ImagePicker();

  getMultipImage() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      pickedImages.forEach((e) {
        images?.add(File(e.path));
      });

      setState(() {});
    }
  }

  Future<String> uploadFile(File file) async {
    final metaData = SettableMetadata(contentType: 'image/jpeg');
    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef
        .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
    final uploadTask = ref.putFile(file, metaData);

    final taskSnapshot = await uploadTask.whenComplete(() => null);
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }


  storeEntry(List<String> imageUrls, String loc, String det, String pho, int ex,
      String con, String? sta, String? cit) {
    FirebaseDatabase.instance.ref.({
      'image': imageUrls,
      "uuid": FirebaseAuth.instance.currentUser?.uid,
      "location": loc, // John Doe
      "detals": det, // Stokes and Sons
      "phone number": pho,
      "expectedrent": ex,
      "contary": con,
      "State": sta,
      "City": cit
    }).then((value) {});
  }
}