import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/workout_tracker/workour_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

// class WorkoutRow extends StatelessWidget {
//   final Map wObj;
//   const WorkoutRow({super.key, required this.wObj});

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Container(
//         margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//         decoration: BoxDecoration(
//             color: TColor.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: Image.asset(
//                 wObj["image"].toString(),
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               width: 15,
//             ),
//             Expanded(
//                 child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   wObj["name"].toString(),
//                   style: TextStyle(
//                       color: TColor.black,
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold),
//                 ),

//                 Text(
//                   "${wObj["time"].toString()}minutes",
//                   style: TextStyle(
//                     color: TColor.gray,
//                     fontSize: 10,
//                   ),
//                 ),

//                 //  const SizedBox(height: 4,),

//                 //   SimpleAnimationProgressBar(
//                 //     height: 15,
//                 //     width: media.width * 0.5,
//                 //     backgroundColor: Colors.grey.shade100,
//                 //     foregrondColor: Colors.purple,
//                 //     ratio: wObj["progress"] as double? ?? 0.0,
//                 //     direction: Axis.horizontal,
//                 //     curve: Curves.fastLinearToSlowEaseIn,
//                 //     duration: const Duration(seconds: 3),
//                 //     borderRadius: BorderRadius.circular(7.5),
//                 //     gradientColor: LinearGradient(
//                 //         colors: TColor.primaryG,
//                 //         begin: Alignment.centerLeft,
//                 //         end: Alignment.centerRight),
//                 //   ),
//               ],
//             )),
//             IconButton(
//                 onPressed: () {},
//                 icon: Image.asset(
//                   "assets/img/next_icon.png",
//                   width: 30,
//                   height: 30,
//                   fit: BoxFit.contain,
//                 ))
//           ],
//         ));
//   }
// }

class WorkoutRow extends StatelessWidget {
  final Map wObj;
  const WorkoutRow({super.key, required this.wObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)]),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                wObj["image"].toString(),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
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
                  wObj["name"].toString(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "${wObj["time"].toString()}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
                // const SizedBox(height: 4),
                // SimpleAnimationProgressBar(
                //   height: 15,
                //   width: media.width * 0.5,
                //   backgroundColor: Colors.grey.shade100,
                //   foregrondColor: Colors.purple,
                //   ratio: wObj["progress"] as double? ?? 0.0,
                //   direction: Axis.horizontal,
                //   curve: Curves.fastLinearToSlowEaseIn,
                //   duration: const Duration(seconds: 3),
                //   borderRadius: BorderRadius.circular(7.5),
                //   gradientColor: const LinearGradient(
                //       colors: [Colors.blue, Colors.green],
                //       begin: Alignment.centerLeft,
                //       end: Alignment.centerRight),
                // ),
              ],
            )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutDetailView(
                        title: wObj['name'],
                        Desc: "${wObj["time"].toString()}",
                      ), // Replace with your actual destination screen
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/img/next_icon.png",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ))
          ],
        ));
  }
}
