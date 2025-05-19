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
    
//    work in real world
//    let container: ModelContainer = {
//        let schema = Schema([Workouts.self])
//        let container = ModelContainer(for: schema, configuratons: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            WorkoutCounterMain()
                .withRouter()
        }
//        .modelContainer(container)
        .modelContainer(for: [Workouts.self])
        .modelContainer(for: [Exercise.self])
    }
}
