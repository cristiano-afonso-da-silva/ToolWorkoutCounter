//
//  ViewExtension.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 16/05/2025.
//

import SwiftUI

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()

    @ViewBuilder
    private func routeView(for route: Route) -> some View {
        switch route {

        case .main:
            WorkoutCounterMain()

        case .select:
            WorkoutCounterSelection()

        case .form(let names):
            WorkoutCounterForm(selectedNames: names)

        case .exercise:
            WorkoutCounterExercise()

        case .exerciseTestData:
            WorkoutCounterExerciseTestData()
        }
    }

    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)
                        .environment(router)
                }
        }
    }
}

extension View {
    func withRouter() -> some View {
        self.modifier(RouterViewModifier())
    }
}

