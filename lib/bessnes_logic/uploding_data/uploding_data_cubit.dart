import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:traelling_app/bessnes_logic/uploding_data/uploding_data_state.dart';
import 'package:traelling_app/prestation_layer/widgets/globle.dart';

class UplodingDataCubit extends Cubit<UplodingDataState> {
  UplodingDataCubit() : super(UplodingDataInitial());
  final databaseReference = FirebaseDatabase.instance.ref();
  final imagedatabase =
      FirebaseDatabase.instance.ref().child('Alhamdllah').push();
  final List<String> UrlPhotos = [];
  Future<void> uploadData(Map<String, dynamic> data) async {
    emit(Loading());
    try {
      await Firebase.initializeApp();

      await databaseReference.child('post').push().set(data);
      print("==============================data send");
    } catch (error) {
      print('=========for data =========$error');
    }
  }

  Future<void> uploadImagesAndSaveUrls(List<File> images) async {
    emit(Loading());
    try {
      final storageRef = FirebaseStorage.instance.ref();

      for (int i = 0; i < images.length; i++) {
        final image = images[i];
        final imageRef = storageRef
            .child('pictures/${DateTime.now().microsecondsSinceEpoch}.jpg');
        await imageRef.putFile(image);
        final imageUrl = await imageRef.getDownloadURL();
        UrlPhotos.add(imageUrl);
      }
      imagedatabase.set(UrlPhotos);
    } catch (error) {
      print('==========for images=========$error');
    }
  }
}
