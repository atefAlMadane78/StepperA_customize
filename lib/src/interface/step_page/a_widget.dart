
import 'package:flutter/cupertino.dart';
import 'package:stepper_a/src/interface/step_page/style_mixin.dart';

abstract class IWidget  with StyleMixin {

  Widget buildBorder(int index);
  Widget buildLine(int index, double size);
  Widget buildWidget(int index, Widget child);
}