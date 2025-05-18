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
                router.navigateToSelect()
            }
            
            Button("Start the last exercise") {
                router.navigateToExercise()
            }
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WorkoutCounterMain()
}
