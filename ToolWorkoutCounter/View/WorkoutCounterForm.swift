//
//  SwiftUIView.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData

private struct DraftExercise: Identifiable {
    let id = UUID()
    let name: String
    var reps = 0
    var time = 0
    var sets = 0
}

struct WorkoutCounterForm: View {
    @Environment(\.modelContext) private var context
    @Environment(Router.self)    private var router

    @State private var drafts: [DraftExercise]
    @State private var showInvalidAlert = false

    init(selectedNames names: [String]) {
        _drafts = State(initialValue: names.map { DraftExercise(name: $0) })
    }

    var body: some View {
        VStack {
            header

            Form {
                ForEach($drafts) { $draft in
                    Section(draft.name) {
                        row("Reps",   bind: $draft.reps)
                        row("Time (s)", bind: $draft.time)
                        row("Sets",   bind: $draft.sets)
                    }
                }
            }
            .formStyle(.grouped)

            Button("Continue", action: saveAndProceed)
                .buttonStyle(.borderedProminent)
                .padding(.top)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .alert("Invalid values",
               isPresented: $showInvalidAlert,
               actions: { Button("OK", role: .cancel) { } },
               message: {
                   Text("Reps, time, and sets must all be greater than zero for every exercise.")
               })
    }

    private var header: some View {
        HStack {
            Button("<") { router.dismiss() }
            Spacer()
            Text("Workout Counter")
            Spacer()
        }
    }

    private func row(_ label: String, bind: Binding<Int>) -> some View {
        HStack {
            Text(label)
            Spacer()
            TextField("0", value: bind, format: .number)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: 80)
        }
    }

    private func saveAndProceed() {
        guard drafts.allSatisfy({ $0.reps > 0 && $0.time > 0 && $0.sets > 0 }) else {
            showInvalidAlert = true
            return
        }

        let workout = Workouts()
        context.insert(workout)

        for d in drafts {
            let ex = Exercise(name: d.name,
                              reps: d.reps,
                              time: d.time,
                              sets: d.sets,
                              workoutID: workout.id)
            workout.exercises.append(ex)
            context.insert(ex)
        }

        router.navigateToExercise()
    }
}
