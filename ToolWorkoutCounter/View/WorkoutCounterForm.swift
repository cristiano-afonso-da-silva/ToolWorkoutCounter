//
//  SwiftUIView.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

//
//  WorkoutCounterForm.swift
//  ToolWorkoutCounter
//

import SwiftUI
import SwiftData

struct WorkoutCounterForm: View {
    // ── Environment & input ───────────────────────────────────────────────
    @Environment(Router.self) private var router
    let workoutID: String

    // ── Fetch only the exercises for this workout ─────────────────────────
    @Query private var exercises: [Exercise]

    init(workoutID: String) {
        self.workoutID = workoutID
        _exercises = Query(filter: #Predicate<Exercise> { $0.workoutID == workoutID })
    }

    // ── UI ────────────────────────────────────────────────────────────────
    var body: some View {
        VStack {
            HStack {
                Button("<") { router.dismiss() }
                Spacer()
                Text("Workout Counter")
                Spacer()
                Button("...") {}
            }

            Form {
                ForEach(exercises) { exercise in
                    ExerciseEditSection(exercise: exercise)
                }
            }
            .formStyle(.grouped)

            Button("Continue") { router.navigateToExercise() }
                .buttonStyle(.borderedProminent)
                .padding(.top)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

// ── Re-usable sub-view that edits ONE exercise ───────────────────────────

private struct ExerciseEditSection: View {
    @Bindable var exercise: Exercise        // ← live binding

    var body: some View {
        Section(exercise.name) {
            field(label: "Reps",   value: $exercise.reps)
            field(label: "Time (s)", value: $exercise.time)
            field(label: "Sets",   value: $exercise.sets)
        }
    }

    private func field(label: String, value: Binding<Int>) -> some View {
        HStack {
            Text(label)
            Spacer()
            TextField("0", value: value, format: .number)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
                .frame(maxWidth: 80)
        }
    }
}
