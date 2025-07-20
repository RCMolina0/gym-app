//
//  WorkoutMenu.swift
//  GymApp
//
//  Created by Robert Molina on 11/27/24.
//

import SwiftUI
import SwiftData
import ConfettiSwiftUI

struct WorkoutMenu: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var user: [User]
    @State var workout: Workout
    @State var exercises: [Exercise] = []
    @State var setsDone: [Int] = []
    @State var isDone: Bool = false
    @State var DonePopupPresented: Bool = false
    @State var workoutTime: TimeInterval = TimeInterval()
    var body: some View {
        VStack{ //vstack that holds the workout title and exercises
            HStack{ //creates the title that mirrors the style of the navmenu
                Text(workout.name).font(.title).bold()
                Spacer()
                if (isDone == true){
                    Button("Done"){
                        workoutTime = user.first!.endWorkout()
                        DonePopupPresented = true
                    }
                }
            }.padding(.horizontal, 20).popover(isPresented: $DonePopupPresented){
                DonePopup(isShowing: $DonePopupPresented, time: workoutTime)
            }
            List{
                ForEach($exercises){exercise in
                    Section(header: Text(exercise.wrappedValue.name)){//creates a new section with the header of the exercise name
                        let id:Int = exercises.firstIndex(of: exercise.wrappedValue)! //index of the exercise
                        VStack{
                            ExerciseHorizontal(exercise: exercise, setsDone: $setsDone[id]).padding(.vertical, 10) //progressbar and other things
                            SetsList(exercise: exercise, setsDone: $setsDone[id]) //lists the sets in order
                        }
                    }
                }
            }
        }.onAppear(){
            if(!user.first!.isWorkingout()){
                user.first!.startWorkout(workout: workout)
            }
            exercises = user.first!.getCurrentWorkout()!.exercises //make the exercises the ones passed in
            setsDone = user.first!.getSetsDone()
        }.onChange(of: setsDone){
            user.first!.updateSetsDone(setsDone)
            for i in 0...exercises.count-1{
                if(setsDone[i] < exercises[i].sets){
                    return
                }
            }
            isDone = true
        }.onChange(of: DonePopupPresented){
            //can only happen if user dismisses workout ending popover so dismiss
            if DonePopupPresented == false{
                dismiss()
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
                    repsDone = exercise.reps[setsDone]
                    weightDone = exercise.weight[setsDone]
                    isShowing = true
                }
            }){
                Image(systemName: "checkmark").tint(.green)
            }.padding(.horizontal, 10)
            //sheet that displays reps and weigth change popup
        }.sheet(isPresented: $isShowing){
            repsDonePopup(isShowing: $isShowing, repsDone: $repsDone, weightDone: $weightDone).presentationDetents([.fraction(0.35)]).onDisappear{
                setsDone += 1;
                exercise.reps[setsDone-1] = repsDone
                exercise.weight[setsDone-1] = weightDone
            }
            //when change reps and weight popup is done showing
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
                //hstack with weight input
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
                Button{
                    isShowing.toggle()
                }label:{
                    Text("Don't Change Anything")
                        .frame(width: UIScreen.main.bounds.width-10, height: 50).background(Color.green).cornerRadius(20).tint(.white).font(.headline)
                }.contentShape(Rectangle()).onAppear(){
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

struct DonePopup: View{
    @Binding var isShowing: Bool
    @State var time: TimeInterval
    @State var trigger: Int = 0
    var body: some View{
        VStack{
            Text("Congratulations").font(.largeTitle).confettiCannon(trigger: $trigger, num: 50, openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
            Text("You workout out for \(Duration.seconds(time).formatted(.units(allowed: [.minutes,.seconds],width: .wide)))")
        }.onAppear(){
            trigger += 1
        }
    }
}

#Preview {
    repsDonePopup(isShowing: .constant(true), repsDone: .constant(5), weightDone: .constant(0.0))
}
