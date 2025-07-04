part of 'home_view_cubit_cubit.dart';

class HomeState {
  final int selectedIndex;
  final bool isDrawerOpen;

  HomeState({
    this.selectedIndex = 0,
    this.isDrawerOpen = false,
  });

  HomeState copyWith({
    int? selectedIndex,
    bool? isDrawerOpen,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isDrawerOpen: isDrawerOpen ?? this.isDrawerOpen,
    );
  }
}
