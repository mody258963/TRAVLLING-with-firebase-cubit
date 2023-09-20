import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:lecle_flutter_absolute_path/lecle_flutter_absolute_path.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:traelling_app/bessnes_logic/uploding_data/uploding_data_cubit.dart';

class Addingpage extends StatefulWidget {
  const Addingpage({super.key});

  @override
  State<Addingpage> createState() => _AddingpageState();
}

class _AddingpageState extends State<Addingpage> {
  final screenCubit = UplodingDataCubit();
  List<Media> selectedImages = [];

  getMultipImage() async {
    List<Media> pickedImages = [];
    pickedImages = await ImagePickers.pickerPaths(
      galleryMode: GalleryMode.image,
    );
    setState(() {
      selectedImages = pickedImages;
    });
    print('===============================$selectedImages');
  }

  Future<void> uploadImages() async {
    List<File>? imageFiles = [];
    for (var image in selectedImages) {
      final filePath =
          await LecleFlutterAbsolutePath.getAbsolutePath(uri: image.path!);
      imageFiles.add(File(filePath!));
    }
    await BlocProvider.of<UplodingDataCubit>(context)
        .uploadImagesAndSaveUrls(imageFiles);
  }

  Widget _Imagepickers() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.08,
      child: BlocProvider(
        create: (context) => screenCubit,
        child: ElevatedButton(
            onPressed: () async {
              getMultipImage();
            },
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.white70,
            ),
            child: const Text(
              "Add image",
            )),
      ),
    );
  }

  Widget _SubmitButtons() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.08,
      child: BlocProvider(
        create: (context) => screenCubit,
        child: ElevatedButton(
            onPressed: () async {
              BlocProvider.of<UplodingDataCubit>(context)
                  .uploadData({'sooo': "12eeq"});
              uploadImages();
            },
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.white70,
            ),
            child: const Text(
              "Add Proberty",
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {}),
            backgroundColor: Colors.white,
            title: const Text(
              "Add Your Proberty",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              _SubmitButtons(),
              const SizedBox(
                height: 34,
              ),
              _Imagepickers()
            ],
          )),
    );
  }
}
