//
//  ViewExtension.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 16/05/2025.
//

import SwiftUI

// MARK: - Router-aware ViewModifier
struct RouterViewModifier: ViewModifier {
    @State private var router = Router()

    // map each Route to its destination view
    @ViewBuilder
    private func routeView(for route: Route) -> some View {
        switch route {

        case .main:
            WorkoutCounterMain()

        case .select(let workoutID):
            WorkoutCounterSelection(workoutID: workoutID)

        case .form(let workoutID):
            WorkoutCounterForm(workoutID: workoutID)

        case .exercise:
            WorkoutCounterExercise()

        case .exerciseTestData:
            WorkoutCounterExerciseTestData()
        }
    }

    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)                     // inject router into root
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)                // lazily build destination
                        .environment(router)             // inject router into child
                }
        }
    }
}

// MARK: - Convenience extension
extension View {
    func withRouter() -> some View {
        self.modifier(RouterViewModifier())
    }
}

