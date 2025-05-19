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
    
    func navigateToForm() {
        path.append(Route.form)
    }
    
    func navigateToSelect() {
        path.append(Route.select)
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
    case form
    case select
    case exercise
    case exerciseTestData
}
