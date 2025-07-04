part of 'my_coupons_view_cubit.dart';

sealed class MyCouponsViewState extends Equatable {
  const MyCouponsViewState();

  @override
  List<Object> get props => [];
}

final class MyCouponsViewInitial extends MyCouponsViewState {}

final class MyCouponsViewLoading extends MyCouponsViewState {}

final class MyCouponsViewLoaded extends MyCouponsViewState {
  final List<MyCouponsModel> mycoupons;
  const MyCouponsViewLoaded(this.mycoupons);
}

final class MyCouponsViewError extends MyCouponsViewState {
  final String message;

  const MyCouponsViewError(this.message);
}
