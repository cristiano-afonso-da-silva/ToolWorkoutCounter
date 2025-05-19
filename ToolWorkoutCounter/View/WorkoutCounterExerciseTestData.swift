//
//  WorkoutCounterTestData.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 18/05/2025.
//

import SwiftUI
import SwiftData

struct WorkoutCounterExerciseTestData: View {
    @Environment(\.modelContext) var context
    @State private var isShowingExerciseSheet = false
    @Query var exercises: [Exercise] = []
    @State private var exerciseToEdit: Exercise?
    
    var body: some View {
        List {
            ForEach(exercises, id: \.id) { exercise in
                ExerciseCell(exercise: exercise)
                    .onTapGesture {
                        exerciseToEdit = exercise
                    }
            }
            .onDelete { indexSet in
                for index in indexSet {
                    context.delete(exercises[index])
                }
            }
        }
        .navigationTitle("Exercise")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $isShowingExerciseSheet) { AddExerciseSheet() }
        .sheet(item: $exerciseToEdit) { exercise in
            UpdateExerciseSheet(exercise: exercise)
        }
        .toolbar {
            if !exercises.isEmpty {
                Button("Add Exercise", systemImage: "plus") {
                    isShowingExerciseSheet = true
                }
            }
        }
        .overlay {
            if exercises.isEmpty {
                ContentUnavailableView(label: {
                    Label("No Exercises", systemImage: "list.bullet.rectangle.portrait")
                }, description: {
                    Text("Start adding exercise to see your list.")
                }, actions: {
                    Button("Add Exercise") { isShowingExerciseSheet = true }
                })
                .offset(y: -60)
            }
        }
    }
}

#Preview {
    WorkoutCounterExerciseTestData()
}

struct ExerciseCell: View {
    
    let exercise: Exercise
    
    var body: some View {
        HStack {
            Text(exercise.name)
            Spacer()
            Text("Reps: \(exercise.reps)")
            Text("Time: \(exercise.time)s")
            Text("Sets: \(exercise.sets)")
        }
    }
    
}

struct AddExerciseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var reps: Int = 0
    @State private var time: Int = 0
    @State private var sets: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise Name", text: $name)
                TextField("Reps", value: $reps, format: .number)
                TextField("Time", value: $time, format: .number)
                TextField("Sets", value: $sets, format: .number)
            }
            .navigationTitle("New Exercise")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        let exercise = Exercise(name: name, reps: reps, time: time, sets: sets)
                        context.insert(exercise)
                        dismiss()
                    }
                }
            }
        }
    }
}

struct UpdateExerciseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var exercise: Exercise
    
    var body: some View {
        Form {
            TextField("Exercise Name", text: $exercise.name)
            TextField("Reps", value: $exercise.reps, format: .number)
            TextField("Time", value: $exercise.time, format: .number)
            TextField("Sets", value: $exercise.sets, format: .number)
        }
        .navigationTitle("Update Exercise")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
