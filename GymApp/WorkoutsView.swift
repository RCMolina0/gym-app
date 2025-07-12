//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//
import SwiftUI
import SwiftData

struct WorkoutsView: View {
    @Environment(\.modelContext) var context //needed to save and remove workouts
    @Query var user: [User] //saved workouts
    @State var workouts: [Workout] = []
    @State var isShowingBuilder: Bool = false //tells when to display workout maker
    @State var isShowingEdit: Bool = false //tells when to display editor
    @State var newWorkout: Workout = Workout() //holds the new workout
    @State var workoutEdit: Workout = Workout() //holds edited workout
    var body: some View {
        ZStack {
            NavigationStack{
                List {
                    //go through each workout and make it a nav link with an edit and delete button
                    ForEach(workouts){workout in
                        NavigationLink(destination: WorkoutMenu(workout: workout)){
                            Text(workout.name).swipeActions {
                                Button(action:{
                                    workouts.remove(at: workouts.firstIndex(of: workout)!)
                                    user.first!.workouts = workouts
                                }){
                                    Image(systemName: "trash")
                                }.tint(.red)
                                Button(action:{
                                    workoutEdit = workout
                                    isShowingEdit.toggle()
                                    if(user.first!.isWorkingout()){
                                        user.first!.endWorkout()
                                    }
                                }){
                                    Image(systemName: "pencil")
                                }.tint(.blue)
                        }
                        }
                    }
                    Button("Add Workout") {
                        newWorkout = Workout()
                        isShowingBuilder.toggle()
                    }.popover(isPresented: $isShowingBuilder){
                        WorkoutBuilder(workout: $newWorkout, isShowing: $isShowingBuilder).onDisappear(){
                            if(!newWorkout.isEmpty()){
                                workouts.append(newWorkout)
                                user.first!.workouts = workouts
                            }
                        }
                    }.popover(isPresented: $isShowingEdit){
                        WorkoutBuilder(workout: $workoutEdit, isShowing: $isShowingEdit)
                    }
                }.navigationTitle("Workouts").onAppear(){
                    workouts = user.first!.workouts
                }
            }
        }
    }
}
 
#Preview {
    WorkoutsView()
}
