import 'package:bloc/bloc.dart';
import 'package:ecowin/api/Services/About_Us_Services/about_us_service.dart';
import 'package:equatable/equatable.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit() : super(AboutUsInitial());

  Future<void> fetchBrands() async {
    try {
      final brands = await AboutUsService.fetchBrands();
      if (!isClosed) emit(AboutUsLoaded(brands));
    } catch (e) {
      if (!isClosed) emit(AboutUsError(e.toString()));
    }
  }
}
