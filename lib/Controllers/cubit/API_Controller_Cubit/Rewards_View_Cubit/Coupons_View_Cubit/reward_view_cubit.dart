import 'package:bloc/bloc.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Models/Rewards%20Models/rewards_model.dart';
import 'package:ecowin/api/Services/Rewards_Services/rewards_services.dart';
import 'package:equatable/equatable.dart';

part 'reward_view_state.dart';

class RewardViewCubit extends Cubit<RewardViewState> {
  RewardViewCubit() : super(RewardViewInitial());

  void fetchRewards(context) async {
    try {
      emit(RewardViewLoading());
      final rewards = await Reedemrewardservice().fetchRewards();
      if (!isClosed) emit(RewardViewLoaded(rewards));
    } catch (e) {
      ScreenDialogs.showFailureDialog(context, "$e", 'Ok', () {});
      if (!isClosed) emit(RewardViewError(e.toString()));
    }
  }

  void redeemRewards(
      int brandid, String discount, String price, context) async {
    try {
      if (!isClosed) emit(RewardViewLoading());
      final response =
          await Reedemrewardservice().redeemReward(brandid, discount, price);
      final couponCode = response['code'];
      if (!isClosed) emit(RewardRedeemSuccess(discount, couponCode));
    } catch (e) {
      print(e);
      if (!isClosed) emit(RewardViewError(e.toString()));
    }
  }
}
