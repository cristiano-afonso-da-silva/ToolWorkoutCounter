//
//  WorkoutCounterSelection.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI

struct WorkoutCounterSelection: View {
    @Environment(Router.self) var router
    @State private var selectedNames: Set<String> = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

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
                        Button(action: {
                            toggleSelection(name)
                        }) {
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
                router.navigateToForm()
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }

    private func toggleSelection(_ name: String) {
        if selectedNames.contains(name) {
            selectedNames.remove(name)
        } else {
            selectedNames.insert(name)
        }
    }
}

#Preview {
    WorkoutCounterSelection()
}
