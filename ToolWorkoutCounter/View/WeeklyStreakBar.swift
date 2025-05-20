//
//  WeeklyStreakBar.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 19/05/2025.
//

import SwiftUI
import SwiftData


fileprivate struct StreakDay: Identifiable {
    let id   = UUID()
    let date: Date
    let isToday: Bool
    let isFuture: Bool
    let isCompleted: Bool
}

struct WeeklyStreakBar: View {

    @Query private var workouts: [Workouts]

    private var bodyDays: [StreakDay] {
        let cal   = Calendar.current
        let today = cal.startOfDay(for: Date())


        func completed(on day: Date) -> Bool {
            workouts.contains { cal.isDate($0.date, inSameDayAs: day) }
        }


        return (-3...2).map { offset -> StreakDay in
            let date       = cal.date(byAdding: .day, value: offset, to: today)!
            let isToday    = offset == 0
            let isFuture   = offset > 0
            let isCompleted = offset < 0 && completed(on: date)
            return StreakDay(date: date,
                             isToday: isToday,
                             isFuture: isFuture,
                             isCompleted: isCompleted)
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(bodyDays.indices, id: \.self) { idx in
                let day = bodyDays[idx]
                VStack(spacing: 4) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(color(for: day))
                            .frame(width: 28, height: 28)

                        if day.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .bold))
                        }
                    }
                    Text(label(for: day))
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }


                if idx != bodyDays.count - 1 {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 24, height: 2)
                }
            }
        }
    }


    private func color(for day: StreakDay) -> Color {
        if day.isToday        { return Color.gray.opacity(0.5) }
        if day.isFuture       { return Color.gray.opacity(0.3) }
        if day.isCompleted    { return Color.orange }
        return Color.gray.opacity(0.3)
    }

    private func label(for day: StreakDay) -> String {
        if day.isToday { return "Today" }
        let fmt = DateFormatter()
        fmt.dateFormat = "E"
        return fmt.string(from: day.date)
    }
}

#Preview {
    NavigationStack {
        VStack {
            WeeklyStreakBar()
                .padding()
        }
        .navigationTitle("Preview")
    }
}
