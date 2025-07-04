part of 'charity_images_cubit.dart';

sealed class CharityImagesState extends Equatable {
  final List<File> charityimages;

  const CharityImagesState(this.charityimages);

  @override
  List<Object> get props => [charityimages];
}

final class InitialCharityImages extends CharityImagesState {
  InitialCharityImages() : super([]);
}

final class UpdatedCharityImages extends CharityImagesState {
  UpdatedCharityImages(super.charityimages);
}
