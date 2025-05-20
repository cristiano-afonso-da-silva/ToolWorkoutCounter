//
//  WorkoutCounterTestData.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 18/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterExerciseTestData: View {
    @Environment(\.modelContext) private var context

    @Query(sort: \Workouts.date, order: .reverse)
    private var workouts: [Workouts]

    @State private var showDeleteAllAlert = false

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
                    WorkoutSection(workout: workout) { deleteExercises(at: $0, in: workout) }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) { delete(workout) } label: {
                                Label("Delete Workout", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle("All Workouts")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            if !workouts.isEmpty {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) { showDeleteAllAlert = true } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .alert("Delete ALL data?",
               isPresented: $showDeleteAllAlert,
               actions: {
                   Button("Cancel", role: .cancel) {}
                   Button("Delete", role: .destructive) { deleteAll() }
               },
               message: { Text("This removes every workout and exercise in the database.") })
    }

    private func delete(_ workout: Workouts)        { context.delete(workout) }
    private func deleteExercises(at offsets: IndexSet, in workout: Workouts) {
        for index in offsets { context.delete(workout.exercises[index]) }
    }
    private func deleteAll() { workouts.forEach(context.delete) }
}

fileprivate struct WorkoutSection: View {
    let workout: Workouts
    let onDelete: (IndexSet) -> Void

    private var header: some View {
        HStack {
            Text(workout.date.formatted(.dateTime.year().month().day()))
            Spacer()
            Text("\(workout.exercises.count) exercise\(workout.exercises.count == 1 ? "" : "s")")
                .foregroundStyle(.secondary)
        }
        .font(.subheadline)
    }

    var body: some View {
        Section(header: header) {
            ForEach(workout.exercises) { exercise in
                ExerciseRow(exercise: exercise)
            }
            .onDelete(perform: onDelete)
        }
    }
}

fileprivate struct ExerciseRow: View {
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
