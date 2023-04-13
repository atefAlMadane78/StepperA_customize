/// /*** Uttam kumar mitra ***/
/// create date 10/04/2023; 11:41 PM
///
///
///
///
///
import 'package:flutter/material.dart';
import 'package:stepper_a/src/provider/stepper_provider.dart';
import 'package:stepper_a/src/step_helper/step.dart';

import '../drawing/drawing_helper.dart';
import '../drawing/path_widget.dart';
import '../line.dart';

class Utils {
  ///for Stepper state management
  final StepperNotifier _notifier;

  ///It is Control Step color and icon.
  final StepA _step;

  ///for Step border radius
  final Radius _radius;

  ///for stepper height and width
  final double _stepperSize;

  ///for step width
  final double _stepWidth;

  ///for step height
  final double _stepHeight;

  ///Step border show or Not
  final bool _border;


  ///for stepper line thickness
  final double _lineThickness;

  ///for stepper strokeWidth
  final double _strokeWidth;

  final Axis _axis;

  const Utils(
      {required notifier,
        required radius,
        required stepperSize,
        required stepWidth,
        required stepHeight,
        required axis,
        required lineThickness,
        required strokeWidth,
        required step,
        required stepBorder
      })
      : _notifier = notifier,
        _radius = radius,
        _stepperSize = stepperSize,
        _stepWidth = stepWidth,
        _stepHeight = stepHeight,
        _axis = axis,
        _lineThickness = lineThickness,
        _strokeWidth = strokeWidth,
        _border = stepBorder,
        _step = step;

  /// build all step
  List<Widget> steps() {
    var list = <Widget>[];
    for (int i = 0; i < _notifier.totalIndex; i++) {
      var borderColor = _getBorderColor(i);
      var lineColor = _getLineColor(i);

      /// step circles
      list.add(
        Stack(
            children: [
          if(_border)Positioned.fill(
              child: PathWidget(
                notifier: _notifier,
                borderShape: _notifier.borderShape,
                borderType: _notifier.borderType,
                dashPattern: _notifier.dashPattern,
                radius: _radius,
                pathColor: borderColor,
                strokeWidth: _strokeWidth,
                taskType: i == _notifier.currentIndex
                    ? TaskType.inProgress
                    : TaskType.pending,
                animationDirection: _notifier.direction,
              )),
          SizedBox(
            height: _stepHeight,
            width: _stepWidth,
            child: _getInnerElementOfStepper(i),
          )
        ]),
      );

      ///line between step circles
      if (i != _notifier.totalIndex - 1) {
        list.add(
          StepperLine(
            lineColor: lineColor,
            length: CalculateLength(
                size: _stepperSize,
                width: _stepWidth,
                height: _stepHeight,
                stepSize: _notifier.totalIndex)
                .length(),
            lineThickness: _lineThickness,
            lineType: _notifier.lineType,
            axis:_axis,
          ),
        );
      }
    }
    return list;
  }

  ///Set step circle color
  Color _getCircleColor(i) {
    Color color;
    if (i < _notifier.currentIndex) {
      color = _step.completeStepColor;
    } else if (i == _notifier.currentIndex) {
      color = _step.currentStepColor;
    } else {
      color = _step.inactiveStepColor;
    }
    return color;
  }

  ///Set step border color
  Color _getBorderColor(i) {
    Color color;
    if (i < _notifier.currentIndex) {
      color = _step.completeStepColor;
    } else if (i == _notifier.currentIndex) {
      color = _step.currentStepColor;
    } else {
      color = _step.inactiveStepColor;
    }
    return color;
  }

  ///set stepper line color
  Color _getLineColor(i) {
    Color color;
    if (i < _notifier.currentIndex - 1) {
      color = _step.completeStepColor;
    } else if (i == _notifier.currentIndex - 1) {
      color = _step.currentStepColor;
    } else {
      color = _step.inactiveStepColor;
    }
    return color;
  }

  ///set stepper text and icon
  Widget _getInnerElementOfStepper(index) {
    if (index < _notifier.currentIndex) {
      return _buildSteps(
          const Icon(
            Icons.check,
            color: Colors.white,
            size: 16.0,
          ),
        index
      );
    } else if (index == _notifier.currentIndex) {
      return _buildSteps(
          Center(
            child: Text(
              '${_notifier.currentIndex + 1}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          index
      );
    } else {
      return _buildSteps(
          Center(
            child: Text(
              '${index + 1}',
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          index
      );
    }
  }

  Widget _buildSteps(Widget child,int index){
    Color circleColor = _getCircleColor(index);
    return AnimatedContainer(
      margin:_border?_step.margin:null,
      duration: const Duration(milliseconds: durationTime),
      decoration: BoxDecoration(
          color: circleColor,
          shape: (_notifier.borderShape==BorderShape.rRect
              || _notifier.borderShape==BorderShape.rect)
              ?BoxShape.rectangle
              :BoxShape.circle,
          borderRadius: BorderRadius.all(_radius)
      ),
      child: child,
    );
  }
}
