import 'dart:convert';
import 'package:fitness/Models/exercise_model.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/workout_tracker/exercises_stpe_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Utils/base_url.dart';

class WorkoutDetailView extends StatefulWidget {
  final String title;
  final String Desc;

  WorkoutDetailView({required this.title, required this.Desc});

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView> {
  late Future<List<Workout>> workouts;

  @override
  void initState() {
    super.initState();
    workouts = fetchWorkouts();
  }

  Future<List<Workout>> fetchWorkouts() async {
    final response = await http
        .get(Uri.parse(BaseURL + 'Hdl_Workouts.ashx?category=${widget.title}'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Workout.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load workouts');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      decoration:
          BoxDecoration(gradient: LinearGradient(colors: TColor.primaryG)),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.transparent,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    "assets/img/black_btn.png",
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      "assets/img/more_btn.png",
                      width: 15,
                      height: 15,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            SliverAppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leadingWidth: 0,
              leading: Container(),
              expandedHeight: media.width * 0.5,
              flexibleSpace: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/detail_top.png",
                  width: media.width * 0.75,
                  height: media.width * 0.8,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: TColor.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: TColor.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.Desc,
                            style: TextStyle(
                              color: TColor.gray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: media.width * 0.05),
                FutureBuilder<List<Workout>>(
                  future: workouts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No workouts available'));
                    } else {
                      final workoutList = snapshot.data!;
                      return ListView.builder(
                        itemCount: workoutList.length,
                        itemBuilder: (context, index) {
                          final workout = workoutList[index];
                          // return ListTile(
                          //   leading: CircleAvatar(
                          //     backgroundColor: Colors.grey,
                          //     child: Icon(Icons.fitness_center,
                          //         color: Colors.white),
                          //   ),
                          //   title: Text(workout.workout),
                          //   subtitle: Text(workout.workoutProc),
                          //   trailing:
                          //       Icon(Icons.arrow_forward, color: Colors.grey),
                          //   onTap: () {
                          //     // Handle tile tap
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) =>
                          //             WorkoutDetailScreen(workout: workout),
                          //       ),
                          //     );
                          //   },
                          // );
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(50),
                                //   child: Image.asset(
                                //     "assets/workouts/" +
                                //         workout.workout +
                                //         ".gif",
                                //     width: 50,
                                //     height: 50,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    "assets/workouts/${workout.workout}.gif",
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        "assets/img/Workout1.png", // Fallback image path
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workout.workout,
                                      style: TextStyle(
                                          color: TColor.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      workout.workoutProc,
                                      style: TextStyle(
                                        color: TColor.gray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ExercisesStepDetails(
                                                    eObj: workout,
                                                  )));
                                    },
                                    icon: Image.asset(
                                      "assets/img/next_go.png",
                                      width: 20,
                                      height: 20,
                                      fit: BoxFit.contain,
                                    ))
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailScreen extends StatelessWidget {
  final Workout workout;

  WorkoutDetailScreen({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.workout),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Workout: ${workout.workout}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Procedure: ${workout.workoutProc}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text('Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(workout.description, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
