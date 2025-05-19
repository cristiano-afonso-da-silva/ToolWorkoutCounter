//
//  WorkoutCounterMain.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterMain: View {
    
    @Environment(\.modelContext) private var context
    @Environment(Router.self) var router
    
    @Query private var workouts: [Workouts]
    
    var body: some View {
        VStack {
            HStack {
                Button("<") {
                }
                Spacer()
                Text("Workout Counter")
                    .font(.headline)
                Spacer()
                Button("...") {
                    
                }
            }
            Spacer()
            
            // Start a new session
            Button("Start a session") {
                startNewSession()
            }
            
            Button("Start the last exercise") {
                router.navigateToExercise()
            }
            
            Button("Check Full Dataset") {
                router.navigateToExerciseTestData()
            }
            .foregroundStyle(.red)
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
    
    private func startNewSession() {
        let workout = Workouts()
        context.insert(workout)
        router.navigateToSelect(workoutID: workout.id)
    }
}

#Preview {
    WorkoutCounterMain()
}
