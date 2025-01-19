// import 'package:fitness/common_widget/round_button.dart';
// import 'package:fitness/view/meal_planner/meal_planner_view.dart';
// import 'package:fitness/view/workout_tracker/workout_tracker_view.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
// import '../sleep_tracker/sleep_tracker_view.dart';

// class SelectView extends StatelessWidget {
//   const SelectView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // var media = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // RoundButton(
//             //     title: "Workout Tracker",
//             //     onPressed: () {
//             //       Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //           builder: (context) => const WorkoutTrackerView(),
//             //         ),
//             //       );
//             //     }),

//             RoundButton(
//                 title: "AI Pushups",
//                 onPressed: () async {
//                   // final response = await http.get(Uri.parse(
//                   //     ''));

//                   // if (response.statusCode == 200) {
//                   //   print('Camera started successfully');
//                   // } else {
//                   //   print('Failed to start camera');
//                   // }
//                   final Uri uri = Uri.parse(
//                       'http://192.168.1.12:8000/tracking/track_pushups/');
//                   if (await canLaunchUrl(uri)) {
//                     await launchUrl(uri,
//                         mode:
//                             LaunchMode.inAppWebView); // Opens in system browser
//                     // If you want to open within an in-app browser, use:
//                     // await launchUrl(uri, mode: LaunchMode.inAppWebView);
//                   } else {
//                     throw 'Could not launch';
//                   }
//                 }),

//             // const SizedBox(height: 15,),

//             //   RoundButton(
//             // title: "Meal Planner",
//             // onPressed: () {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //       builder: (context) => const MealPlannerView(),
//             //     ),
//             //   );
//             // }),

//             // const SizedBox(height: 15,),

//             //   RoundButton(
//             // title: "Sleep Tracker",
//             // onPressed: () {
//             //   Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //       builder: (context) => const SleepTrackerView(),
//             //     ),
//             //   );
//             // })
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectView extends StatefulWidget {
  final List<CameraDescription> cameras;
  const SelectView({Key? key, required this.cameras}) : super(key: key);

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  String? selectedExercise;
  CameraController? controller;
  bool isTracking = false;
  String result = "No tracking yet.";
  Timer? trackingTimer;
  bool isFrontCamera = true;
  double accuracy = 0.0; // New variable to store accuracy

  List<String> exercises = ["pushups", "squats", "bicep_curls", "pullups"];

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      final cameraIndex = isFrontCamera ? 1 : 0;
      controller = CameraController(
          widget.cameras[cameraIndex], ResolutionPreset.medium,
          enableAudio: false);
      await controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<void> processFrame() async {
    if (!isTracking || controller == null || !controller!.value.isInitialized)
      return;

    try {
      XFile image = await controller!.takePicture();
      List<int> imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final response = await http.post(
        Uri.parse(
            'http://192.168.43.48:8000/tracking/track/$selectedExercise/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'frame': base64Image}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          result = responseData['result'];
          // Assuming the backend now returns an accuracy value
          accuracy = responseData['accuracy'] ?? 0.0;
        });
      } else {
        print("Failed to process frame: ${response.statusCode}");
        print("Response body: ${response.body}");
        setState(() {
          result = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("Error processing frame: $e");
      setState(() {
        result = "Processing error: $e";
      });
    }
  }

  void startTracking() {
    if (!isTracking) {
      setState(() {
        isTracking = true;
        result = "Tracking started...";
      });
      trackingTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        processFrame();
      });
    }
  }

  void stopTracking() {
    if (isTracking) {
      trackingTimer?.cancel();
      setState(() {
        isTracking = false;
        result = "Tracking stopped.";
      });
      resetExercise();
    }
  }

  Future<void> resetExercise() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.43.48:8000/tracking/reset/'),
      );
      if (response.statusCode == 200) {
        setState(() {
          result = "Counters reset successfully.";
          accuracy = 0.0; // Reset accuracy
        });
      } else {
        setState(() {
          result = "Error resetting counters: ${response.statusCode}";
        });
      }
    } catch (e) {
      print("Error resetting exercise: $e");
      setState(() {
        result = "Error resetting exercise: $e";
      });
    }
  }

  void toggleCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
      initializeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    trackingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Workout Tracker")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<String>(
            hint: Text("Select Exercise"),
            value: selectedExercise,
            onChanged: (value) {
              setState(() {
                selectedExercise = value;
                result = "No tracking yet.";
                accuracy = 0.0; // Reset accuracy when exercise is changed
              });
            },
            items: exercises.map((exercise) {
              return DropdownMenuItem(
                value: exercise,
                child: Text(exercise.replaceAll("_", " ").toUpperCase()),
              );
            }).toList(),
          ),
          if (controller != null && controller!.value.isInitialized)
            AspectRatio(
              aspectRatio: 5 / 4,
              child: CameraPreview(controller!),
            ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: toggleCamera,
            child: Text(isFrontCamera
                ? "Switch to Back Camera"
                : "Switch to Front Camera"),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: selectedExercise != null && !isTracking
                    ? startTracking
                    : null,
                child: Text("Start"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: isTracking ? stopTracking : null,
                child: Text("Stop"),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: selectedExercise != null ? resetExercise : null,
                child: Text("Reset"),
              ),
            ],
          ),

          SizedBox(height: 5),
          Text(result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          // New: Accuracy Indicator
          Container(
            width: 300,
            child: Column(
              children: [
                Text("Accuracy", style: TextStyle(fontSize: 16)),
                LinearProgressIndicator(
                  value: accuracy,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(accuracy < 0.3
                      ? Colors.red
                      : accuracy < 0.7
                          ? Colors.yellow
                          : Colors.green),
                ),
                Text("${(accuracy * 100).toStringAsFixed(1)}%",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
