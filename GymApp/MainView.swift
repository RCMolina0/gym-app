//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//
import SwiftUI
import SwiftData

struct MainView: View {
    @State var user = User()
    @State var isShowingBuilder: Bool = false
    @State var isShowingBuilderEdit: Bool = false
    @State var id: Int = 0
    @State var newWorkout: Workout = Workout()
    @State var workoutToUse: Workout = Workout()
    @State var showingWorkout: Bool = false
    var body: some View {
        ZStack {
            NavigationStack{
                List {
                    ForEach(user.workouts){workout in
                        NavigationLink(destination: WorkoutMenu(workout: $newWorkout)){
                            Text(workout.name)
                        }
                    }
                    Button("Add Workout") {
                        newWorkout = Workout()
                        isShowingBuilder.toggle()
                    }.popover(isPresented: $isShowingBuilder){
                        WorkoutBuilder(workout: $newWorkout, isShowing: $isShowingBuilder).onDisappear(){
                            if(!newWorkout.isEmpty()){
                                user.workouts.append(newWorkout)
                            }
                        }
                    }
                }.navigationTitle("Workouts")
            }
        }
    }
}
 
#Preview {
    MainView()
}
