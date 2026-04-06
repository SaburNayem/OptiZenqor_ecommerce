import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optizenqor/app_route/app_route.dart';
import 'package:optizenqor/app_bloc/app_cubit.dart';
import 'package:optizenqor/app_bloc/app_state.dart';
import 'package:optizenqor/core/constant/app_color.dart';

class OptiZenqor extends StatelessWidget {
  const OptiZenqor({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<AppCubit>(create: (_) => AppCubit()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        builder: (BuildContext context, AppState state) {
          return MaterialApp(
            title: 'Optizenqor Store',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: state.useMaterial3,
              scaffoldBackgroundColor: AppColor.background,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColor.primary,
                primary: AppColor.primary,
                secondary: AppColor.accent,
                surface: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                foregroundColor: AppColor.textPrimary,
                centerTitle: false,
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColor.border),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: AppColor.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColor.primary,
                    width: 1.4,
                  ),
                ),
              ),
            ),
            initialRoute: AppRoute.splash,
            onGenerateRoute: AppRoute.onGenerateRoute,
          );
        },
      ),
    );
  }
}
