//
//  User.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//

import SwiftUI
import SwiftData

@Model
class User {
    var name: String
    var workouts: [Workout]
    var exercises: [Exercise]
    init(){
        self.name = "Robert"
        self.workouts = []
        self.exercises = []
    }
    init(name: String){
        self.name = name
        self.workouts = []
        self.exercises = []
    }
    func isEmpty() -> Bool {
        if workouts.isEmpty && exercises.isEmpty {
            return true
        } else {
            return false
        } 
    }
}
