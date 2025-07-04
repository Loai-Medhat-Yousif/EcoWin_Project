import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Views/Charity_Views/charity_saved_adresses.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'charity_images_state.dart';

class CharityImagesCubit extends Cubit<CharityImagesState> {
  CharityImagesCubit() : super(InitialCharityImages());

  addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      final List<File> updatedImageslist = [...state.charityimages, image];
      emit(UpdatedCharityImages(updatedImageslist));
    }
  }

  removeImage(int index) {
    final List<File> updatedImageslist = [...state.charityimages];
    updatedImageslist.removeAt(index);
    emit(UpdatedCharityImages(updatedImageslist));
  }

  void submitCharityOrder(BuildContext context, String numberofpieces,
      String description, final List<File> charityimageslist) {
    if (state.charityimages.isEmpty) {
      ScreenDialogs.showWarningDialog(
          context, "Please Add Charity Images", "ok", () {});
    } else if (numberofpieces.isEmpty) {
      ScreenDialogs.showWarningDialog(
          context, "Please Add Number of Pieces", "ok", () {});
    } else if (description.isEmpty) {
      ScreenDialogs.showWarningDialog(
          context, "Please Add Description", "ok", () {});
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CharitySavedAdresses(
                  pieces: numberofpieces,
                  description: description,
                  charityimageslist: charityimageslist)));
    }
  }
}
