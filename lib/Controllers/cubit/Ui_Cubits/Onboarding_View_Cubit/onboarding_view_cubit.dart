import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_view_state.dart';

class OnboardingViewCubit extends Cubit<OnboardingViewState> {
  OnboardingViewCubit() : super(OnboardingViewControl());

  PageController pageController = PageController(initialPage: 0);
  bool islastpage = false;

  Future<void> skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('ShowHome', true);
    emit(OnboardingViewDone());
  }

  void onPageChanged(int index) {
    if (index == 2) {
      islastpage = true;
      emit(OnboardingViewControl(isLastPage: islastpage));
    } else {
      islastpage = false;
      emit(OnboardingViewControl(isLastPage: islastpage));
    }
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
