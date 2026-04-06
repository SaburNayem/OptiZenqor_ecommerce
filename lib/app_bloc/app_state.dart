import 'package:flutter/material.dart';

@immutable
class AppState {
  const AppState({this.useMaterial3 = true});

  final bool useMaterial3;

  AppState copyWith({bool? useMaterial3}) {
    return AppState(useMaterial3: useMaterial3 ?? this.useMaterial3);
  }
}
