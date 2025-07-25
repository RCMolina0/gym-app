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
    private var weightHistory: [[Double]]
    private var repHistory: [[Int]]
    private var dateHistory: [Date]
    init(name: String, description: String, reps: [Int], sets: Int, weight: [Double]){
        self.name = name
        self.desc = description
        self.reps = reps
        self.sets = sets
        self.weight = weight
        self.weightHistory = [[]]
        self.repHistory = [[]]
        self.dateHistory = []
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
        self.weightHistory = [[]]
        self.repHistory = [[]]
        self.dateHistory = []
    }
    init(){
        self.name = ""
        self.desc = ""
        self.reps = [1]
        self.sets = 1
        self.weight = [0.0]
        self.weightHistory = [[]]
        self.repHistory = [[]]
        self.dateHistory = []
    }
    func isEmpty() -> Bool{
        if name.isEmpty || desc.isEmpty{
            return true
        }
        return false
    }
    func endWorkout(){
        for i in 0...sets-1{
            if i < weightHistory.count{
                weightHistory[i].append(weight[i])
                repHistory[i].append(reps[i])
            }else{
                print(i)
                weightHistory.append([weight[i]])
                repHistory.append([reps[i]])
            }
        }
        dateHistory.append(Date.now)
    }
    //uses epley formula
    func OneRepMaxAlgo() -> [[IntOverDate]]{
        var toReturn: [[IntOverDate]] = [[]]
        if weightHistory == [[]]{
            return [[]]
        }
        print("weightHistory is \(weightHistory.count)")
        print("repHistory is \(repHistory.count)")
        for j in 0...self.weightHistory.count-1{
            for i in 0...self.weightHistory[j].count-1{
                let a = self.weightHistory[j][i] * (Double)(1 + 30/(self.repHistory[j][i]))
                toReturn[j].append(.init(value: Int(floor(a)), date: dateHistory[i]))
            }
        }
        return toReturn
    }
}
