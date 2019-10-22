import 'package:cash_calc/utils/app_colors.dart';
import 'package:flutter/widgets.dart';

BoxDecoration appGradient = BoxDecoration(
  gradient: LinearGradient(
      colors: [AppColors.olive, AppColors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: const [0.7, 1]),
);
