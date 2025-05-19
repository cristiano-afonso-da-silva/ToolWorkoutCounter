//
//  WorkoutCounterSelection.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterSelection: View {
    
    @Environment(\.modelContext) private var context
    @Environment(Router.self) var router
    
    private let workoutID: String
    @Query private var workouts: [Workouts]
    
    @State private var selectedNames: Set<String> = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(workoutID: String) {
        self.workoutID = workoutID
        _workouts = Query(filter: #Predicate<Workouts> { $0.id == workoutID })
    }

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
                            toggleSelection(name)
                        } label: {
                            Text(name)
                                .foregroundStyle(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(
                                    selectedNames.contains(name)
                                    ? Color.orange
                                    : Color.gray.opacity(0.3)
                                )
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            Spacer()
            
            Button("Continue") {
                addExercisesAndProceed()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }

    private var currentWorkout: Workouts? { workouts.first }

    private func toggleSelection(_ name: String) {
        if selectedNames.remove(name) == nil { selectedNames.insert(name) }
    }

    private func addExercisesAndProceed() {
        guard let workout = currentWorkout, !selectedNames.isEmpty else { return }

        for name in selectedNames {
            // avoid duplicates if user backs up and re-selects
            if !workout.exercises.contains(where: { $0.name == name }) {
                let ex = Exercise(name: name, workoutID: workout.id)
                workout.exercises.append(ex)
                context.insert(ex)
            }
        }
        router.navigateToForm(workoutID: workout.id)
    }
}
