import 'package:flutter/cupertino.dart';

/// /*** Uttam kumar mitra ***/
/// create date 14/04/2023; 11:41 PM
///
///

class CustomSteps {
  final IconData? stepsIcon;
  final Image? image;
  final String? title;
  final TextAlign? textAlign;
  final Widget? customChild;

  const CustomSteps( {
    this.stepsIcon,
    this.image, required this.textAlign, this.customChild,
    this.title,
  });
}
