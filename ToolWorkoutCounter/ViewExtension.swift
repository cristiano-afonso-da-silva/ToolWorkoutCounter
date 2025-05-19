//
//  ViewExtension.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 16/05/2025.
//

import Foundation
import SwiftUI

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()
    
    private func routeView(for route: Route) -> some View {
        Group {
            switch route {
            case .main:
                WorkoutCounterMain()
            case .form:
                WorkoutCounterForm()
            case .select:
                WorkoutCounterSelection()
            case .exercise:
                WorkoutCounterExercise()
            case .exerciseTestData:
                WorkoutCounterExerciseTestData()
            }
        }
        .environment(router)
    }
    
    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)
                }
        }
    }
}

extension View {
    func withRouter() -> some View {
        modifier(RouterViewModifier())
    }
}
