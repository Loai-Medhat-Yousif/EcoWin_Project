import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/api/Services/Profile%20Service/edit_profile_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> editProfilePicture() async {
    emit(EditProfileLoading());
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        await EditProfileService().UpdatePicture(pickedFile);
        emit(EditProfileSuccess());
      }
      if (pickedFile == null) {
        emit(EditProfileFailure(message: "No Image Selected"));
      }
    } catch (e) {
      emit(EditProfileFailure(message: e.toString()));
    }
  }

  Future<void> editProfileData(
      String name, String email, String phone, context) async {
    emit(EditProfileLoading());
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp emailRegex = RegExp(emailPattern);
    RegExp phoneRegex = RegExp(r'^(010|011|012|015)\d{8}$');

    if (name.isEmpty) {
      emit(EditProfileInitial());
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your full name',
        'Ok',
        () {},
      );
    } else if (!emailRegex.hasMatch(email)) {
      emit(EditProfileInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid email address', 'Ok', () {});
    } else if (phone.isEmpty) {
      emit(EditProfileInitial());
      ScreenDialogs.showWarningDialog(
        context,
        'Please enter your phone number',
        'Ok',
        () {},
      );
    } else if (!phoneRegex.hasMatch(phone)) {
      emit(EditProfileInitial());
      ScreenDialogs.showWarningDialog(
          context, 'Please enter a valid phone number', 'Ok', () {});
    } else {
      try {
        await EditProfileService().UpdateProfile(
          name,
          email,
          phone,
        );
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileFailure(message: e.toString()));
      }
    }
  }
}
