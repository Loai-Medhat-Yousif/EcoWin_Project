import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Models/Rewards%20Models/my_coupons_model.dart';
import 'package:ecowin/api/Services/Rewards_Services/my_coupons_service.dart';
import 'package:equatable/equatable.dart';

part 'my_coupons_view_state.dart';

class MyCouponsViewCubit extends Cubit<MyCouponsViewState> {
  MyCouponsViewCubit() : super(MyCouponsViewInitial());

  Future<void> fetchMyCoupons(context) async {
    try {
      if (!isClosed) emit(MyCouponsViewLoading());
      final myCoupons = await MyCouponsService().fetchmyCoupons();
      if (myCoupons.isEmpty) {
        if (!isClosed) emit(NoCouponsFound());
        return;
      }
      if (!isClosed) emit(MyCouponsViewLoaded(myCoupons));
    } catch (e) {
      print(e);
      ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
      if (!isClosed) emit(MyCouponsViewError(e.toString()));
    }
  }
}
