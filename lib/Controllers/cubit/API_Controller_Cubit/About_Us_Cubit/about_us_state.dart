part of 'about_us_cubit.dart';

sealed class AboutUsState extends Equatable {
  const AboutUsState();

  @override
  List<Object> get props => [];
}

final class AboutUsInitial extends AboutUsState {}

final class AboutUsLoaded extends AboutUsState {
  final List<String> brandImages;
  const AboutUsLoaded(this.brandImages);
}

final class AboutUsError extends AboutUsState {
  final String error;
  const AboutUsError(this.error);
}
