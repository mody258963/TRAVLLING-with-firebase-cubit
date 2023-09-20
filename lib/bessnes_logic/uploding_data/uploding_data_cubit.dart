import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:traelling_app/bessnes_logic/uploding_data/uploding_data_state.dart';

class UplodingDataCubit extends Cubit<UplodingDataState> {
  UplodingDataCubit() : super(UplodingDataInitial());

  Future<void> uploadData(Map<String, dynamic> data) async {
    emit(Loading());
    try {
      await Firebase.initializeApp();
      final databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child('post').push().set(data);
      print("==============================data send");
      emit(true as UplodingDataState);
    } catch (error) {
      print('==================error');
    }
  }

  Future<void> uploadImagesAndSaveUrls(List<File> images) async {
    emit(Loading());
    try {
      final storageRef = FirebaseStorage.instance.ref();

      for (int i = 0; i < images.length; i++) {
        final image = images[i];
        final imageRef = storageRef.child('images/image_$i.jpg');
        await imageRef.putFile(image);
        final imageUrl = await imageRef.getDownloadURL();

        // Save the image URL to the Realtime Database
        await FirebaseDatabase.instance
            .ref()
            .child('post')
            .set({'url': imageUrl});
      }
    } catch (error) {
      print('===================uplodingImageField');
    }
  }
}
