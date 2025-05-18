//
//  SwiftUIView.swift
//  ToolWorkoutCounter
//
//  Created by Cristiano Afonso da Silva on 15/05/2025.
//

import SwiftUI

struct WorkoutCounterForm: View {
    
    @Environment(Router.self) var router
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var reps: String = ""
    @State private var sets: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button("<") { router.dismiss() }
                Spacer()
                Text("Workout Counter")
                Spacer()
            }
            HStack {
                Text("Set your reps, and choose your time")
                Spacer()
            }
            Spacer()
            ScrollView {
                VStack {
                    VStack {
                        HStack {
                            Text("Exercise Name")
                            Spacer()
                        }
                        HStack {
                            Text("Reps")
                            TextField(text: $reps, prompt: Text("required")) {
                                
                            }
                            Text("Sets")
                            TextField(text: $sets, prompt: Text("required")) {
                            }
                            Spacer()
                        }
                    }
                    VStack {
                        HStack {
                            Text("Exercise Name")
                            Spacer()
                        }
                        HStack {
                            Text("Reps")
                            TextField(text: $reps, prompt: Text("required")) {
                                
                            }
                            Text("Sets")
                            TextField(text: $sets, prompt: Text("required")) {
                            }
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
            Button("Continue") { router.navigateToExercise() }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WorkoutCounterForm()
}
