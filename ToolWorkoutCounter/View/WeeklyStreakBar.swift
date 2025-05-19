//
//  WeeklyStreakBar.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 19/05/2025.
//

import SwiftUI
import SwiftData

/// One cell’s state
fileprivate struct StreakDay: Identifiable {
    let id   = UUID()
    let date: Date
    let isToday: Bool
    let isFuture: Bool
    let isCompleted: Bool
}

struct WeeklyStreakBar: View {
    // ── Fetch ALL workouts so we can check past days ------------
    @Query private var workouts: [Workouts]

    private var bodyDays: [StreakDay] {
        let cal   = Calendar.current
        let today = cal.startOfDay(for: Date())

        // Helper: does any workout exist on this date?
        func completed(on day: Date) -> Bool {
            workouts.contains { cal.isDate($0.date, inSameDayAs: day) }
        }

        // Build −3 … +2 day offsets (6 boxes; today is offset 0 → 4th box)
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

                // draw connecting line except after the last box
                if idx != bodyDays.count - 1 {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 24, height: 2)
                }
            }
        }
    }

    // ── Color logic ---------------------------------------------------------
    private func color(for day: StreakDay) -> Color {
        if day.isToday        { return Color.gray.opacity(0.5) }   // light-gray
        if day.isFuture       { return Color.gray.opacity(0.3) }   // dark-gray
        if day.isCompleted    { return Color.orange }              // ✓ orange
        return Color.gray.opacity(0.3)                             // dark-gray
    }

    // e.g. “Fri”, “Sat”, “Today”
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
