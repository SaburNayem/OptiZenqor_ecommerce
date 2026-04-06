import 'package:flutter/material.dart';

@immutable
class NavigationState {
  const NavigationState({required this.currentIndex});

  final int currentIndex;

  NavigationState copyWith({int? currentIndex}) {
    return NavigationState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
