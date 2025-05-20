//
//  WorkoutCounterSelection.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterSelection: View {
    
    @Environment(Router.self) var router
    
    @State private var selected: Set<String> = []
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            HStack {
                Button("<") { router.dismiss() }
                Spacer()
                Text("Workout Counter")
                Spacer()
                Button("...") {}
            }
            Text("Select the workout")
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(Workouts.presetExerciseNames, id: \.self) { name in
                        Button {
                            if selected.contains(name) {
                                selected.remove(name)
                            } else {
                                selected.insert(name)
                            }
                        } label: {
                            Text(name)
                                .foregroundStyle(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(selected.contains(name) ? .orange
                                             : .gray.opacity(0.3))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            
            Button("Continue") {
                router.navigateToForm(Array(selected))
            }
            .buttonStyle(.borderedProminent)
            .disabled(selected.isEmpty)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
