import 'package:bloc/bloc.dart';
import 'package:ecowin/Views/Auth_Views/SignIn_Views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_view_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PageController pageController = PageController();
  HomeCubit() : super(HomeState());

  void changeIndex(int index) {
    pageController.jumpToPage(index);
    emit(state.copyWith(selectedIndex: index));
  }

  void openDrawer() {
    emit(state.copyWith(isDrawerOpen: true));
  }

  void closeDrawer() {
    emit(state.copyWith(isDrawerOpen: false));
  }

  void toggleDrawer() {
    emit(state.copyWith(isDrawerOpen: !state.isDrawerOpen));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isRemembered', false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
