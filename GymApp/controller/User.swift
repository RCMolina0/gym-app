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
    private var currentWorkoutIndex: Int = -1
    private var currentWorkoutSetsDone: [Int]
    var WorkoutStart: Date = Date()
    init(){
        self.name = "Robert"
        self.workouts = []
        self.currentWorkoutIndex = -1
        self.currentWorkoutSetsDone = []
    }
    init(name: String){
        self.name = name
        self.workouts = []
        self.currentWorkoutIndex = -1
        self.currentWorkoutSetsDone = []
    }
    func isEmpty() -> Bool {
        if workouts.isEmpty || name.isEmpty{
            return true
        } else {
            return false
        }
    }
    func startWorkout(workout: Workout){
        currentWorkoutIndex = workouts.firstIndex(of: workout)!
        WorkoutStart = Date.now
        self.currentWorkoutSetsDone = []
        print(self.currentWorkoutSetsDone.count)
        //fills setsdone array with 0
        for _ in 0...workouts[currentWorkoutIndex].exercises.count{
            currentWorkoutSetsDone.append(0)
        }
    }
    func getCurrentWorkout() -> Workout?{
        guard currentWorkoutIndex != -1 else { return nil }
        return workouts[currentWorkoutIndex]
    }
    func endWorkout() -> TimeInterval{
        currentWorkoutIndex = -1
        return WorkoutStart.distance(to: Date.now)
    }
    func isWorkingout() -> Bool{
        print(currentWorkoutIndex)
        return currentWorkoutIndex != -1
    }
    func getSetsDone() -> [Int]{
        return currentWorkoutSetsDone
    }
    func updateSetsDone(_ input: [Int]){
        currentWorkoutSetsDone = input
    }
}
