//
//  WorkoutCounterExercise.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI

struct WorkoutCounterExercise: View {
    
    @Environment(Router.self) var router
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var speed = 50.0
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                Button("X") { router.popToRoot() }
                Spacer()
                Text("Workout Counter")
                Spacer()
                Button("...") {
                    
                }
            }
            Spacer()
            VStack {
                Image(systemName: "star")
                Text("Push Up")
                HStack {
                    VStack {
                        Text("10")
                        Text("reps")
                    }
                    VStack {
                        Text("2")
                        Text("min")
                    }
                }
            }
            Spacer()
            ZStack {
                StreakView(completedDates: sampleData())
            }
            HStack {
                Image(systemName: "star")
                VStack {
                    Image(systemName: "star.fill")
                    Text("Push Up Exercise")
                }
                Image(systemName: "star")
            }
            Slider(
                        value: $speed,
                        in: 0...100,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
            Text("\(speed)")
                .foregroundColor(isEditing ? .red : .blue)

        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

func sampleData() -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return [
            calendar.date(byAdding: .day, value: -2, to: today)!,
            calendar.date(byAdding: .day, value: -1, to: today)!,
            today
        ]
}

struct StreakDay: Identifiable {
    let id = UUID()
    let date: Date
    var isCompleted: Bool
    var isToday: Bool
}

struct StreakView: View {
    let completedDates: [Date]  // Input data
    @State private var streakDays: [StreakDay] = []

    var body: some View {
        VStack(spacing: 12) {
            if streakDays.isEmpty {
                Text("No Streak")
                    .foregroundColor(.gray)
                    .font(.headline)
            } else {
                HStack(spacing: 12) {
                    ForEach(streakDays) { day in
                        VStack(spacing: 4) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(backgroundColor(for: day))
                                    .frame(width: 28, height: 28)

                                if day.isCompleted {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14, weight: .bold))
                                }
                            }
                            Text(dayLabel(for: day.date, isToday: day.isToday))
                                .font(.caption2)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                }
            }
        }
        .onAppear(perform: generateStreakDays)
    }

    func generateStreakDays() {
        guard !completedDates.isEmpty else {
            streakDays = []
            return
        }

        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        // Always generate 7 days with today in the middle (4th position)
        var tempDays: [StreakDay] = []

        for offset in (-3)...3 {
            if let date = calendar.date(byAdding: .day, value: offset, to: today) {
                let isCompleted = completedDates.contains(where: { calendar.isDate($0, inSameDayAs: date) })
                let isToday = calendar.isDate(date, inSameDayAs: today)
                tempDays.append(StreakDay(date: date, isCompleted: isCompleted, isToday: isToday))
            }
        }

        streakDays = tempDays
    }

    func backgroundColor(for day: StreakDay) -> Color {
        if day.isToday {
            return .gray.opacity(0.6)
        } else if day.isCompleted {
            return .orange
        } else {
            return .gray.opacity(0.3)
        }
    }

    func dayLabel(for date: Date, isToday: Bool) -> String {
        if isToday { return "Today" }
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // e.g., Mon, Tue
        return formatter.string(from: date)
    }
}

#Preview {
    WorkoutCounterExercise()
}
