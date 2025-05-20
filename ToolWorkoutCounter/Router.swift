//
//  Router.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 16/05/2025.
//

import SwiftUI
import Observation

@Observable
class Router {
    var path = NavigationPath()
    
    func navigateToMain() {
        path.append(Route.main)
    }
    
    func navigateToSelect() {
        path.append(Route.select)
    }
    
    func navigateToForm(_ names: [String]) {
        path.append(Route.form(names))
    }
    
    func navigateToExercise() {
        path.append(Route.exercise)
    }
    
    func navigateToExerciseTestData() {
        path.append(Route.exerciseTestData)
    }
    
    func dismiss() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}

enum Route: Hashable {
    case main
    case select
    case form([String])
    case exercise
    case exerciseTestData
}
