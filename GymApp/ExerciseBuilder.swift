//
//  ExerciseBuilder.swift
//  GymApp
//
//  Created by Robert Molina on 11/25/24.
//

import SwiftUI

struct ExerciseBuilder: View {
    @Binding var exercise: Exercise
    @Binding var isPresented: Bool
    @State var name: String = ""
    @State var description: String = ""
    @State var reps: [Int] = [1]
    @State var sets: Int = 1
    @State var showingAlert: Bool = false
    @State var weight: Double?
    var body: some View {
        Button("Click here to be done"){
            if(name.isEmpty || description.isEmpty || weight == nil){
                showingAlert = true;
            }else{
                exercise = Exercise(name: name, description: description, reps: reps, sets: sets, weight: weight!)
                isPresented = false;
            }
        }.alert("Please enter a name and description",isPresented: $showingAlert){
        }
        List {
            TextField("Name", text: $name)
            TextField("Description", text: $description)
            TextField("Weight", value: $weight,formatter: NumberFormatter()).keyboardType(.decimalPad)
            Button("Add Set"){
                reps.append(1);
                sets+=1;
            }
            ForEach(0..<sets, id: \.self){i in
                VStack{
                    TextField("Reps", value: $reps[i],formatter: NumberFormatter()).keyboardType(.decimalPad)
                }
            }
        }.onAppear(){
            name = exercise.name
            description = exercise.desc
            reps = exercise.reps
            sets = exercise.sets
        }
    }
}

#Preview {
    ExerciseBuilder(exercise: .constant(Exercise()), isPresented: .constant(true))
}
