//
//  Workouts.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 18/05/2025.
//

import Foundation
import SwiftData

@Model
class Exercise: Identifiable {
    var name: String
    var reps: Int
    var time: Int
    var sets: Int

    init(name: String, reps: Int = 0, time: Int = 0, sets: Int = 0) {
        self.name = name
        self.reps = reps
        self.time = time
        self.sets = sets
    }
}

@Model
class Workouts: Identifiable {
    var id: String
    var date: Date
    var exercises: [Exercise] = []

    static let presetExerciseNames: [String] = [
      "Push Up", "Diamond Push Up", "Squat", "Plank",
      "Lunge", "Burpee", "Mountain Climber", "Sit Up",
      "Bicycle Crunch", "Jump Squat", "Pull Up", "Dip",
      "Muscle Up", "Reverse Rowing", "Deadlift", "Bench Press",
      "Dumbbell Row", "Kettlebell Swing", "Shoulder Press", "Bicep Curl"
    ]

    init() {
        self.id = UUID().uuidString
        self.date = .now
    }
}
