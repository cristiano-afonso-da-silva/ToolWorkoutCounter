//
//  WorkoutCounterMain.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterMain: View {
    
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
            
            Button("Start a session") {
                router.navigateToSelect()
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
}

#Preview {
    WorkoutCounterMain()
}
