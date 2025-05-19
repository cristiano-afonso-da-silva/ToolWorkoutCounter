//
//  ToolWorkoutCounterApp.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

@main
struct ToolWorkoutCounterApp: App {
    
    var body: some Scene {
        WindowGroup {
            WorkoutCounterMain()
                .withRouter()
        }
        .modelContainer(for: [Workouts.self, Exercise.self])
    }
}
