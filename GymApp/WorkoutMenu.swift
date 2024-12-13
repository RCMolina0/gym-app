//
//  WorkoutMenu.swift
//  GymApp
//
//  Created by Robert Molina on 11/27/24.
//

import SwiftUI
import SwiftData

struct WorkoutMenu: View {
    @Environment(\.modelContext) var context
    @Query var workouts: [Workout]
    @State var workout: Workout = Workout()
    @State var idx: Int
    @State var exercises: [Exercise] = []
    @State var setsDone: [Int] = []
    var body: some View {
        VStack() {
            HStack{
                Text(workout.name).font(.title).bold()
                Spacer()
            }.padding(.horizontal, 20)
            List{
                ForEach($exercises){exercise in
                    Section(header: Text(exercise.wrappedValue.name)){
                        let id:Int = exercises.firstIndex(of: exercise.wrappedValue)!
                        VStack{
                            ExerciseHorizontal(exercise: exercise, setsDone: $setsDone[id]).padding(.vertical, 10)
                            SetsList(exercise: exercise, setsDone: $setsDone[id])
                        }
                    }
                }
            }
        }.onAppear(){
            workout = workouts[idx]
            exercises = workout.exercises
            for _ in 0...exercises.count-1{
                setsDone.append(0)
            }
        }
    }
}

struct ExerciseHorizontal: View{
    @Binding var exercise: Exercise
    @State var repsDone: Int = 0
    @Binding var setsDone: Int
    @State var weightDone: Double = 0.0
    @State var isShowing:Bool = false
    var body: some View{
        HStack{
            ProgressView(value: Double(setsDone), total: Double(exercise.sets))
            Button(action:{
                if(setsDone != exercise.sets){
                    setsDone += 1;
                    repsDone = exercise.reps[setsDone-1]
                    weightDone = exercise.weight[setsDone-1]
                    isShowing = true;
                }
            }){
                Image(systemName: "checkmark").tint(.green)
            }.padding(.horizontal, 10)
        }.sheet(isPresented: $isShowing){
            repsDonePopup(isShowing: $isShowing, repsDone: $repsDone, weightDone: $weightDone).presentationDetents([.fraction(0.35)]).onDisappear{
                exercise.reps[setsDone-1] = repsDone
                exercise.weight[setsDone-1] = weightDone
            }
        }
    }
}

struct repsDonePopup: View{
    @Binding var isShowing: Bool
    @Binding var repsDone: Int
    @Binding var weightDone: Double
    @State var weightDoneLocal: Double = 0
    @State var repsDoneLocal: Int = 0
    var body: some View{
        ZStack {
            VStack{
                Text("Enter the amount of reps done").font(.headline)
                HStack{
                    HStack{
                        Spacer()
                        Text("Reps")
                        TextField("reps", value: $repsDoneLocal,formatter: NumberFormatter()).keyboardType(.numberPad)
                    }.frame(width: 150).background(Color.gray).clipShape(RoundedRectangle(cornerRadius: 10)).multilineTextAlignment(.center)
                    Button("", systemImage: "checkmark", action:{
                        repsDone = repsDoneLocal
                    }).padding(.horizontal, 10).background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).tint(.white).font(.headline)
                }.padding()
                HStack{
                    HStack{
                        Spacer()
                        Text("Weight")
                        TextField("weight", value: $weightDoneLocal,formatter: NumberFormatter()).keyboardType(.decimalPad)
                    }.frame(width: 150).background(Color.gray).clipShape(RoundedRectangle(cornerRadius: 10)).multilineTextAlignment(.center)
                    Button("", systemImage: "checkmark", action:{
                        weightDone = weightDoneLocal
                    }).padding(.horizontal, 10).background(Color.green).clipShape(RoundedRectangle(cornerRadius: 10)).tint(.white).font(.headline)
                }.padding()
                Button("Don't Change Anything"){
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
                    Text("\(exercise.weight[i], specifier: "%.2f") lbs")
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
    repsDonePopup(isShowing: .constant(true), repsDone: .constant(5), weightDone: .constant(0.0))
}
