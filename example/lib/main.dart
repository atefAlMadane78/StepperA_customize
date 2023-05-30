import 'package:example/step_four.dart';
import 'package:example/step_one.dart';
import 'package:example/step_three.dart';
import 'package:example/step_two.dart';
import 'package:flutter/material.dart';
import 'package:stepper_a/stepper_a.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StepperExample(),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({Key? key}) : super(key: key);

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  final StepperAController controller = StepperAController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(82),
              child: AppBar(
                title: const Text("Stepper Example"),
              )),
        ),
        Positioned(
          top: 98,
          //top: 75,
          left: 0,
          right: 0,
          bottom: 0,
          //MediaQuery.of(context).size.height-240
          child: StepperA(
              stepperSize: const Size(300, 95),
              borderShape: BorderShape.circle,
              borderType: BorderType.straight,
              stepperAxis: Axis.horizontal,
              lineType: LineType.dotted,
              stepperBackgroundColor: Colors.transparent,
              stepperAController: controller,
              stepHeight: 40,
              stepWidth: 40,
              stepBorder: true,
              pageSwipe: true,
              formValidation: true,

              // floatingPreviousButton: FloatingButton(
              //     buttonIconColor: Colors.white,
              //     backgroundColor:  Colors.blueAccent,
              //     position: Position(//
              //         left: 10,
              //         bottom: 10
              //     )
              // ),
              // floatingForwardButton: FloatingButton(
              //     buttonIconColor: Colors.white,
              //     backgroundColor:  Colors.blueAccent,
              //     position: Position(
              //         right: 10,
              //         bottom: 20
              //     )
              // ),
              previousButton: (int index) => StepperAButton(
                    width: 90,
                    height: 40,
                    buttonWidget: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
              forwardButton: (index) => StepperAButton(
                    width: index == 0 ? MediaQuery.of(context).size.width-40 : MediaQuery.of(context).size.width-120,
                    height: 40,
                    boxDecoration: BoxDecoration(
                      color: index == 3?Colors.indigo: Colors.green,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    buttonWidget: index == 3
                        ? const Text('Complete',
                            style: TextStyle(fontSize: 14, color: Colors.white))
                        : const Text('Next',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                  ),
              customSteps: [
                const CustomSteps(stepsIcon: Icons.login, title: "LogIn"),
                const CustomSteps(stepsIcon: Icons.home, title: "Home"),
                const CustomSteps(stepsIcon: Icons.account_circle, title: "Account"),
                CustomSteps(image: Image.asset("assets/pic/pay.png", color: Colors.white), title: "Payment"),
              ],
              step: const StepA(
                  currentStepColor: Colors.green,
                  completeStepColor: Colors.indigo,
                  inactiveStepColor: Colors.black45,
                  // loadingWidget: CircularProgressIndicator(color: Colors.green,),
                  margin: EdgeInsets.all(5)),
              stepperBodyWidget: [
                StepOne(controller: controller),
                StepTwo(controller: controller),
                StepThree(controller: controller),
                StepFour(controller: controller),
              ],
          ),
        ),
      ],
    );
  }
}
