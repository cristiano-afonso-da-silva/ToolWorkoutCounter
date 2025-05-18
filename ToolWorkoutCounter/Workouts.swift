//
//  Expense.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 16/05/2025.
//

import Foundation
import SwiftData


@Model
class Workouts {
    var workouts: [Workout]
    var date: Date
    
    init(workouts: [Workout], date: Date) {
        self.workouts = workouts
        self.date = date
    }
}

class Workout {
    var workout: [Exercise]
    
    init(workout: [Exercise]) {
        self.workout = workout
    }
}

class Exercise {
    var name: String
    var reps: Int
    var time: Int
    var sets: Int
    
    init(name: String, reps: Int, time: Int, sets: Int) {
        self.name = name
        self.reps = reps
        self.time = time
        self.sets = sets
    }
}

