//
//  WorkoutBuilder.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//

import SwiftUI
import SwiftData

struct WorkoutBuilder: View {
    @Binding var workout: Workout
    @Binding var isShowing: Bool
    @State var name: String = ""
    @State var id: Int = 0
    @State var exercises: [Exercise] = []
    @State var newExercise: Exercise = Exercise()
    @State var isShowingExerciseBuilder: Bool = false
    @State var isShowingExerciseBuilderEdit: Bool = false
    @State var showingAlert: Bool = false
    var body: some View {
        Button("yes"){
            if(!name.isEmpty && !exercises.isEmpty){
                workout.name = name
                workout.exercises = exercises
                isShowing.toggle()
            }else{
                showingAlert = true;
            }
        }.alert("Please enter a name and at least one exercise",isPresented: $showingAlert){
        }
        List{
            HStack{Text("Name:")
                TextField("Name", text: $name)}
            ForEach(exercises){exercise in
                Text(exercise.name).swipeActions {
                    Button(action:{workout.exercises.remove(at: workout.exercises.firstIndex(of: exercise)!)
                        exercises = workout.exercises
                    }){
                        Image(systemName: "trash")
                    }.tint(.red)
                    Button(action:{newExercise = exercise
                        id = workout.exercises.firstIndex(of: exercise)!
                        isShowingExerciseBuilderEdit = true
                    }){
                        Image(systemName: "pencil")
                    }.tint(.blue)
                }
            }.popover(isPresented: $isShowingExerciseBuilderEdit){
                ExerciseBuilder(exercise: $newExercise, isPresented: $isShowingExerciseBuilderEdit).onDisappear(){
                    if(!newExercise.isEmpty()){
                        print("on disappeared")
                        workout.exercises.remove(at: id)
                        workout.exercises.insert(newExercise, at: id)
                        exercises = workout.exercises
                    }
                }
            }
            Button("Add exercise"){
                newExercise = Exercise()
                isShowingExerciseBuilder.toggle()
            }.popover(isPresented: $isShowingExerciseBuilder){
                ExerciseBuilder(exercise: $newExercise, isPresented: $isShowingExerciseBuilder)
                    .onDisappear(){
                        if(!newExercise.isEmpty()){
                            workout.exercises.append(newExercise)
                            exercises = workout.exercises
                        }
                }
            }.onDisappear(){
                if(!newExercise.isEmpty()){
                    exercises.append(newExercise)
                    workout.exercises.append(newExercise)
                }
            }
        }.onAppear{
            name = workout.name
            exercises = workout.exercises
        }.padding(.top)
    }
}

#Preview {
    let w: Workout = Workout(name: "robert testing")
    WorkoutBuilder(workout: .constant(w), isShowing: .constant(true))
}
#Preview {
    WorkoutBuilder(workout: .constant(Workout()), isShowing: .constant(true))
}
