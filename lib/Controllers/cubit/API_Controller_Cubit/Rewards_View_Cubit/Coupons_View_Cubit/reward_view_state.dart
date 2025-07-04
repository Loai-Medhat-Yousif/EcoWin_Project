part of 'reward_view_cubit.dart';

sealed class RewardViewState extends Equatable {
  const RewardViewState();

  @override
  List<Object> get props => [];
}

final class RewardViewInitial extends RewardViewState {}

final class RewardViewError extends RewardViewState {
  final String message;
  const RewardViewError(this.message);
}

final class RewardViewLoaded extends RewardViewState {
  final List<RewardsModel> rewards;
  const RewardViewLoaded(this.rewards);
}

final class RewardViewLoading extends RewardViewState {}

final class RewardRedeemSuccess extends RewardViewState {
  final String discount;
  final String couponcode;
  const RewardRedeemSuccess(this.discount, this.couponcode);
}

final class RewardRedeemError extends RewardViewState {
  final String message;
  const RewardRedeemError(this.message);
}
