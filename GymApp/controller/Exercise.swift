//
//  Exercise.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//

import SwiftUI
import SwiftData

@Model
public class Exercise: Identifiable{
    var name: String
    var desc: String
    var reps: [Int]
    var sets: Int
    var weight: [Double]
    init(name: String, description: String, reps: [Int], sets: Int, weight: [Double]){
        self.name = name
        self.desc = description
        self.reps = reps
        self.sets = sets
        self.weight = weight
    }
    init(name: String, description: String, reps: Int, sets: Int, weight: Double){
        self.name = name
        self.desc = description
        var rep: [Int] = []
        for _ in 1...sets{
            rep.append(reps)
        }
        var weigt: [Double] = []
        for _ in 1...sets{
            weigt.append(weight)
        }
        self.weight = weigt
        self.reps = rep
        self.sets = sets
    }
    init(){
        self.name = ""
        self.desc = ""
        self.reps = [1]
        self.sets = 1
        self.weight = [0.0]
    }
    func isEmpty() -> Bool{
        if name.isEmpty || desc.isEmpty{
            return true
        }
        return false
    }
    
}
