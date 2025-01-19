import 'package:fitness/Models/exercise_model.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/round_button.dart';

class ExercisesStepDetails extends StatefulWidget {
  final Workout eObj; // The selected exercise object

  const ExercisesStepDetails({super.key, required this.eObj});

  @override
  State<ExercisesStepDetails> createState() => _ExercisesStepDetailsState();
}

class _ExercisesStepDetailsState extends State<ExercisesStepDetails> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/closed_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Image.asset(
                "assets/img/more_btn.png",
                width: 15,
                height: 15,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: media.width,
                    height: media.width * 0.43,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(colors: TColor.primaryG),
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.asset(
                      "assets/workouts/" + widget.eObj.workout + ".gif",
                      width: media.width,
                      height: media.width * 0.43,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Container(
                  //   width: media.width,
                  //   height: media.width * 0.43,
                  //   child: Icon(Icons.play_circle_outline,
                  //       size: 50, color: Colors.white),
                  // ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: TColor.secondaryColor1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            border: Border.all(color: TColor.white, width: 3),
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.eObj.workout,
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          widget.eObj.description,
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              RoundButton(title: "Start Workout", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
