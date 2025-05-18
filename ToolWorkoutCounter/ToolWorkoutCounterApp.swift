//
//  ToolWorkoutCounterApp.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI

@main
struct ToolWorkoutCounterApp: App {
    
    var body: some Scene {
        WindowGroup {
            WorkoutCounterMain()
                .withRouter()
        }
        .modelContainer(for: Workouts.self)
    }
}
