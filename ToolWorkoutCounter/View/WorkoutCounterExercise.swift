//
//  WorkoutCounterExercise.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI
import SwiftData
import Combine

struct WorkoutCounterExercise: View {
    
    @Environment(Router.self) private var router


    @Query(sort: \Workouts.date, order: .reverse)
    private var workouts: [Workouts]


    private var workout: Workouts? { workouts.first }


    private var exerciseList: [Exercise] { workout?.exercises ?? [] }
    private var exerciseCount: Int      { exerciseList.count }
    private var activeExercise: Exercise? {
        guard currentExercise < exerciseList.count else { return nil }
        return exerciseList[currentExercise]
    }
    
    private enum TimerState { case stopped, running, paused }
    @State private var state: TimerState = .stopped

    @State private var currentExercise = 0
    @State private var currentSet      = 1
    @State private var elapsed         = 0

    @State private var timerCancellable: AnyCancellable?

    // MARK: – View
    var body: some View {
        VStack(spacing: 16) {
            header
            WeeklyStreakBar()
            Spacer(minLength: 8)

            if let exercise = activeExercise {
                exerciseDetails(for: exercise)
                progressBar(for: exercise)
            } else {
                emptyState
            }

            Spacer()

            controlButtons
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onDisappear { stopTimer() }
    }

    private var header: some View {
        HStack {
            Button("X") { router.popToRoot() }
            Spacer()
            Text("Workout Counter")
            Spacer()
        }
        .font(.headline)
    }

    private func exerciseDetails(for ex: Exercise) -> some View {
        VStack(spacing: 4) {
            Text(ex.name).font(.title2.bold())
            HStack(spacing: 24) {
                Label("\(ex.reps) reps",  systemImage: "repeat")
                Label("\(ex.sets) sets",  systemImage: "square.stack.3d.up")
                Label(formatSeconds(ex.time), systemImage: "timer")
            }
            .font(.subheadline)
            Text("Set \(currentSet) / \(ex.sets)")
                .font(.caption).foregroundStyle(.secondary)
        }
    }

    private func progressBar(for ex: Exercise) -> some View {
        VStack {
            Slider(value: .constant(Double(elapsed)),
                   in: 0...Double(ex.time))
                .disabled(true)
            Text(formatSeconds(elapsed))
                .monospacedDigit()
                .font(.system(.body, design: .rounded))
        }
    }

    private var emptyState: some View {
        ContentUnavailableView(label: {
            Label("No Workouts", systemImage: "figure.strengthtraining.traditional")
        }, description: {
            Text("Start a session to create your first workout.")
        })
        .offset(y: -60)
    }

    private var controlButtons: some View {
        HStack(spacing: 24) {
            if exerciseCount > 0 {
                switch state {
                case .stopped:
                    Button("Start")   { startTimer() }
                        .buttonStyle(.borderedProminent)

                case .running:
                    Button("Pause")   { pauseTimer() }
                        .buttonStyle(.borderedProminent)
                    Button("Stop")    { stopTimer() }
                        .buttonStyle(.bordered)

                case .paused:
                    Button("Resume")  { resumeTimer() }
                        .buttonStyle(.borderedProminent)
                    Button("Stop")    { stopTimer() }
                        .buttonStyle(.bordered)
                }
            }
        }
    }

    private func startTimer() {
        guard activeExercise?.time ?? 0 > 0 else { return }
        state   = .running
        elapsed = 0
        scheduleTick()
    }

    private func pauseTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        state = .paused
    }

    private func resumeTimer() {
        state = .running
        scheduleTick()
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
        state = .stopped
        elapsed = 0
        currentExercise = 0
        currentSet = 1
    }

    private func scheduleTick() {
        timerCancellable = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in tick() }
    }

    private func tick() {
        guard state == .running, let exercise = activeExercise else { return }

        elapsed += 1

        if elapsed >= exercise.time {
            elapsed = 0
            if currentSet < exercise.sets {
                currentSet += 1
            } else {
                currentExercise += 1
                currentSet = 1
                if currentExercise >= exerciseCount { stopTimer(); return }
            }
        }
    }

    private func formatSeconds(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%02d:%02d", m, s)
    }
}

#Preview {
    NavigationStack { WorkoutCounterExercise() }
}

