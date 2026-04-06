import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/feature/master/navigation/navigation_controller/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({int initialIndex = 0})
    : super(NavigationState(currentIndex: initialIndex));

  void selectTab(int index) {
    if (index == state.currentIndex) {
      return;
    }
    emit(state.copyWith(currentIndex: index));
  }
}
