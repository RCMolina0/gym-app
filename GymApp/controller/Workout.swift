//
//  Workout.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//
import SwiftUI
import SwiftData

@Model
class Workout: Identifiable {
    var name: String
    var exercises: [Exercise]
    init(name: String) {
        self.name = name
        self.exercises = []
    }
    init(){
        self.name = ""
        self.exercises = []
    }
    init(name: String,exercises: [Exercise]){
        self.name = name
        self.exercises = exercises
    }
    func isEmpty() -> Bool {
        if (exercises.isEmpty || name.isEmpty){
            return true
        } else {
            return false
        }
    }
    func endWorkout(){
        for exercise in exercises {
            exercise.endWorkout()
        }
    }
}

