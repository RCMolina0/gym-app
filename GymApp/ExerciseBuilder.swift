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
    @State var weight: [Double] = [0.0]
    var body: some View {
        HStack {
            Button("cancel"){
                isPresented = false
            }.tint(.red)
            Spacer()
            Button("confirm"){
                if(name.isEmpty || description.isEmpty){
                    showingAlert = true;
                }else{
                    exercise = Exercise(name: name, description: description, reps: reps, sets: sets, weight: weight)
                    isPresented = false;
                }
            }.alert("Please enter a name and description",isPresented: $showingAlert){
            }
        }.padding(.top).padding(.horizontal)
        List {
            Section(header: Text("")){
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            Section(header: Text("Sets")){
                ForEach(0..<sets, id: \.self){i in
                    VStack{
                        HStack{
                            Text("Reps: ")
                            TextField("Reps", value: $reps[i],formatter: NumberFormatter()).keyboardType(.numberPad)
                            Text("Weight: ")
                            TextField("Weight", value: $weight[i],formatter: NumberFormatter()).keyboardType(.decimalPad)
                            Text("lbs")
                        }
                    }
                }
                Button("Add Set"){
                    sets+=1
                    reps.append(1)
                    weight.append(0.0)
                }
            }.onAppear(){
                name = exercise.name
                description = exercise.desc
                reps = exercise.reps
                sets = exercise.sets
            }
        }
    }
}

#Preview {
    ExerciseBuilder(exercise: .constant(Exercise()), isPresented: .constant(true))
}
