//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//
import SwiftUI
import SwiftData

struct WorkoutsView: View {
    @Environment(\.modelContext) var context
    
    @Query var workouts: [Workout]
    @State var isShowingBuilder: Bool = false
    @State var newWorkout: Workout = Workout()
    var body: some View {
        ZStack {
            NavigationStack{
                List {
                    ForEach(workouts){workout in
                        NavigationLink(destination: WorkoutMenu(idx: workouts.firstIndex(of: workout) ?? 0)){
                            Text(workout.name).swipeActions {
                            Button(action:{
                                context.delete(workout)
                            }){
                                Image(systemName: "trash")
                            }.tint(.red)
                        }
                        }
                    }
                    Button("Add Workout") {
                        newWorkout = Workout()
                        isShowingBuilder.toggle()
                    }.popover(isPresented: $isShowingBuilder){
                        WorkoutBuilder(workout: $newWorkout, isShowing: $isShowingBuilder).onDisappear(){
                            if(!newWorkout.isEmpty()){
                                context.insert(newWorkout)
                            }
                        }
                    }
                }.navigationTitle("Workouts")
            }
        }
    }
}
 
#Preview {
    WorkoutsView()
}
