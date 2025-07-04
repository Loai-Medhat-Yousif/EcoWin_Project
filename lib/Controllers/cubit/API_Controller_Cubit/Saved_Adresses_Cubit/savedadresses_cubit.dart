import 'dart:io';

import 'package:ecowin/Models/Adress%20Models/saveded_adresses_model.dart';
import 'package:ecowin/api/Services/Charity_Services/charity_donation_service.dart';
import 'package:ecowin/api/Services/Exchange_Services/send_order_services.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'savedadresses_state.dart';

class SavedadressesCubit extends HydratedCubit<SavedadressesState> {
  SavedadressesCubit() : super(InitialAdressCardstate());

  addadress(
    String governate,
    String city,
    String streetadress,
    String buildno,
    String phone,
  ) {
    final newSavedAdress = Savedadressesmodel(
      id: DateTime.now().millisecondsSinceEpoch,
      governate: governate,
      city: city,
      streetadress: streetadress,
      buildno: buildno,
      phone: phone,
    );
    emit(UpdatedAdressCardState([newSavedAdress, ...state.savedadressescard]));
  }

  deleteadress(int id) {
    final updatedsavedadressescard = state.savedadressescard
        .where((savedadressescard) => savedadressescard.id != id)
        .toList();
    emit(UpdatedAdressCardState(updatedsavedadressescard));
  }

  editadress(
    int id,
    String governate,
    String city,
    String streetadress,
    String buildno,
    String phone,
  ) {
    final List<Savedadressesmodel> newdsavedadressescard =
        state.savedadressescard.map((savedadressescard) {
      return savedadressescard.id == id
          ? savedadressescard.copyWith(
              id: id,
              governate: governate,
              city: city,
              streetadress: streetadress,
              buildno: buildno,
              phone: phone,
            )
          : savedadressescard;
    }).toList();

    emit(UpdatedAdressCardState(newdsavedadressescard));
  }

  Future<void> sendOrder(
    String governate,
    String city,
    String streetadress,
    String buildno,
    String phone,
    List<Map<String, dynamic>> selectedItemsList,
  ) async {
    try {
      emit(LoadingAdressCardState(state.savedadressescard));

      await SendOrderService().addCart(selectedItemsList);
      await SendOrderService()
          .sendAdressDetails(streetadress, governate, city, buildno, phone);

      emit(SucessfulAdressCardState(state.savedadressescard));
    } catch (e) {
      emit(ErrorAdressCardState(state.savedadressescard, e.toString()));
    }
  }

  void resetToDefault() {
    emit(UpdatedAdressCardState(state.savedadressescard));
  }

  Future<void> sendCharityOrder(
      String governate,
      String city,
      String streetadress,
      String buildno,
      String phone,
      String description,
      String pieces,
      final List<File> charityimageslist) async {
    emit(LoadingAdressCardState(state.savedadressescard));
    await CharityDonationService().sendDonation(charityimageslist, streetadress,
        governate, city, description, pieces, buildno, phone);
    emit(SucessfulAdressCardState(state.savedadressescard));
  }

  @override
  SavedadressesState? fromJson(Map<String, dynamic> json) {
    return UpdatedAdressCardState(
      (json["SavedAdressList"] as List)
          .map((savedadressescard) =>
              Savedadressesmodel.adresscardfromjson(savedadressescard))
          .toList(),
    );
  }

  @override
  Map<String, dynamic>? toJson(state) {
    return {
      "SavedAdressList": state.savedadressescard
          .map((savedadressescard) => savedadressescard.adresscardtojson())
          .toList(),
    };
  }
}
