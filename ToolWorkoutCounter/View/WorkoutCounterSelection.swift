//
//  WorkoutCounterSelection.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI

struct WorkoutCounterSelection: View {
    
    @Environment(Router.self) var router
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            HStack {
                Button("<") { router.dismiss() }
                Spacer()
                Text("Workout Counter")
                Spacer()
                Button("...") {
                    
                }
            }
            HStack {
                Text("Select the workout")
                Spacer()
            }
            Spacer()
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0...100, id: \.self) { value in
                        Button(String(format: "%x", value)) {
                        }
                    }
                }
            }
            Spacer()
            Button("Continue") { router.navigateToForm()}
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WorkoutCounterSelection()
}
