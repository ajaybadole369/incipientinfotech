import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import 'home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => Get.offAll(() => const HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [AppColors.kPrimary, AppColors.kWhite],
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: const [0.4, 0.4])),
      child: Scaffold(
        backgroundColor: AppColors.kTransparent,
        body: Container(
            alignment: Alignment.center,
            child: Text(
              'Welcome To Incipient Infotech',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 36,
                  color: AppColors.kPrimary,
                  fontWeight: FontWeight.w700),
            )),
      ),
    );
  }
}
