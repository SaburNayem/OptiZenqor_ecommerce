import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/app_bloc/app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  void setMaterial3(bool value) {
    emit(state.copyWith(useMaterial3: value));
  }
}
