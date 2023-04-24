
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inci/res/app_colors.dart';
import 'package:inci/view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
              foregroundColor: AppColors.kWhite,
              backgroundColor: AppColors.kPrimary),
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: AppColors.kWhite,
          )),
      home: const SafeArea(child: SplashView()),
    );
  }
}
