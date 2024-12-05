//
//  WorkoutMenu.swift
//  GymApp
//
//  Created by Robert Molina on 11/27/24.
//

import SwiftUI

struct WorkoutMenu: View {
    @Binding var workout: Workout
    @State var exercises: [Exercise] = []
    @State var setsDone: Int = 0
    var body: some View {
        VStack() {
            Text(workout.name).font(.title)
            List{
                ForEach($exercises){exercise in
                    VStack{
                        ExerciseHorizontal(exercise: exercise, setsDone: $setsDone).padding(.vertical, 10)
                        SetsList(exercise: exercise,setsDone: $setsDone)
                    }
                }
            }
        }.onAppear(){
            exercises = workout.exercises
        }
    }
}

struct ExerciseHorizontal: View{
    @Binding var exercise: Exercise
    @State var repsDone: Int = 0
    @Binding var setsDone: Int
    @State var isShowing:Bool = false
    var body: some View{
        HStack{
            Text(exercise.name).padding(.horizontal, 10)
            ProgressView(value: Double(setsDone), total: Double(exercise.sets))
            Button(action:{
                if(setsDone != exercise.sets){
                    setsDone += 1;
                    repsDone = exercise.reps[setsDone-1]
                    isShowing = true;
                }
            }){
                Image(systemName: "checkmark").tint(.green)
            }.padding(.horizontal, 10)
        }.sheet(isPresented: $isShowing){
            repsDonePopup(isShowing: $isShowing, repsDone: $repsDone).presentationDetents([.fraction(0.25)]).onDisappear{
                exercise.reps[setsDone-1] = repsDone
            }
        }
    }
}

struct repsDonePopup: View{
    @Binding var isShowing: Bool
    @Binding var repsDone: Int
    @State var repsDoneLocal: Int = 0
    var body: some View{
        ZStack {
            VStack{
                Text("Enter the amount of reps done").font(.headline)
                HStack{
                    TextField("reps", value: $repsDoneLocal,formatter: NumberFormatter()).frame(width: 100).background(Color.gray).clipShape(RoundedRectangle(cornerRadius: 10)).multilineTextAlignment(.center)
                    Button("", systemImage: "checkmark", action:{
                        repsDone = repsDoneLocal
                        isShowing.toggle()
                    }).padding(.horizontal, 10).background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).tint(.white).font(.headline)
                }.padding()
                Button("Don't Change Reps"){
                    
                    isShowing.toggle()
                }.frame(width: UIScreen.main.bounds.width-10, height: 50).background(Color.green).cornerRadius(20).tint(.white).font(.headline).onAppear(){
                    repsDoneLocal = repsDone
                }
            }
        }.onAppear(){
            repsDoneLocal = repsDone
        }
    }
}

struct SetsList: View{
    @Binding var exercise: Exercise
    @Binding var setsDone: Int
    var body: some View {
        VStack{
            ForEach(0..<exercise.reps.count, id: \.self){ i in
                HStack{
                    Text("\(exercise.reps[i]) reps")
                    Spacer()
                    if(setsDone < i+1){
                        Image(systemName: "checkmark.circle")
                    }else{
                        Image(systemName: "checkmark.circle.fill")
                    }
                }.padding(.horizontal, 10)
            }
        }
    }
}
#Preview {
    let exercises: [Exercise] = [Exercise(name: "Exercise Name", description: "Description", reps: 5, sets: 3, weight: 1.2)]
    let workout: Workout = Workout(name: "Workout Name",exercises: exercises)
    WorkoutMenu(workout: .constant(workout))
}
#Preview {
    repsDonePopup(isShowing: .constant(true), repsDone: .constant(5))
}
