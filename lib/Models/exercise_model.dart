class Workout {
  final int exerciseID;
  final String category;
  final String workout;
  final String workoutProc;
  final String description;

  Workout({
    required this.exerciseID,
    required this.category,
    required this.workout,
    required this.workoutProc,
    required this.description,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      exerciseID: json['ExerciseID'],
      category: json['Category'],
      workout: json['Workout'],
      workoutProc: json['WorkoutProc'],
      description: json['Description'],
    );
  }
}
