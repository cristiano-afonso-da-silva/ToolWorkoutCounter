//
//  WorkoutCounterTestData.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 18/05/2025.
//

//
//  WorkoutCounterExerciseTestData.swift
//  ToolWorkoutCounter
//

import SwiftUI
import SwiftData

struct WorkoutCounterExerciseTestData: View {
    @Environment(\.modelContext) private var context

    /// Live list of every workout in the store (newest first)
    @Query(sort: \Workouts.date, order: .reverse)
    private var workouts: [Workouts]

    var body: some View {
        List {
            if workouts.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Workouts", systemImage: "list.bullet.rectangle.portrait")
                }, description: {
                    Text("Start a session to create your first workout.")
                })
                .offset(y: -60)
            } else {
                ForEach(workouts) { workout in
                    Section(header: header(for: workout)) {
                        ForEach(workout.exercises) { exercise in
                            ExerciseRow(exercise: exercise)
                        }
                    }
                }
            }
        }
        .navigationTitle("All Workouts")
        .navigationBarTitleDisplayMode(.large)
    }

    // MARK: - Helpers --------------------------------------------------------

    private func header(for workout: Workouts) -> some View {
        HStack {
            Text(workout.date.formatted(.dateTime.year().month().day()))
            Spacer()
            Text("\(workout.exercises.count) exercise\(workout.exercises.count == 1 ? "" : "s")")
                .foregroundStyle(.secondary)
        }
        .font(.subheadline)
    }
}

// ── Sub-row showing a single exercise --------------------------------------

private struct ExerciseRow: View {
    let exercise: Exercise

    var body: some View {
        HStack {
            Text(exercise.name)
            Spacer()
            Text("\(exercise.reps) reps")
            Text("\(exercise.time)s")
            Text("\(exercise.sets) sets")
        }
        .font(.footnote)
    }
}

#Preview {
    NavigationStack {
        WorkoutCounterExerciseTestData()
    }
}
