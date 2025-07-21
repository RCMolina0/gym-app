//
//  HistoryView.swift
//  GymApp
//
//  Created by Robert Molina on 7/8/25.
//

import SwiftUI
import SwiftData
import Charts

struct HistoryView: View {
    @Query var user: [User] //saved workouts
    @State var navigateTo: AnyView?
    @State var isNavigationActive = false
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        Text("History").font(.title2)
            NavigationView{
                LazyVGrid(columns: columns){
                    ForEach(user.first!.workouts){ workout in
                        Button{
                            navigateTo = AnyView(WorkoutHistoryView(workout: workout))
                            isNavigationActive = true
                        }label:{
                            RoundedRectangle(cornerRadius: 20).fill(.white).stroke(.customGray)
                                .frame(maxWidth: .infinity).aspectRatio(1, contentMode: .fit)
                                .overlay{
                                    VStack{
                                        Image(systemName: "chart.line.uptrend.xyaxis").resizable().scaledToFit().containerRelativeFrame(.horizontal){ size,axis in
                                            size * 0.25
                                        }
                                        Text(workout.name)
                                    }
                                }
                        }
                    }
                }.padding()
                .background(
                    NavigationLink(destination: navigateTo,isActive: $isNavigationActive){
                        EmptyView()
                    })
            }
        }
}

struct IntOverDate{
    var value: Int
    var date: Date
}

struct WorkoutHistoryView: View{
    @State var workout: Workout
    let columns = [GridItem(.flexible())]
    var body: some View{
        LazyVGrid(columns: columns){
            ForEach(workout.exercises){exercise in
                ExerciseHistoryView(exercise: exercise)
            }
        }
    }
}
struct ExerciseHistoryView: View{
    @State var exercise: Exercise
    var body: some View{
        VStack{
            Text("One Rep max History").font(.title)
            Spacer()
            Chart{
                ForEach(exercise.OneRepMaxAlgo().first!, id: \.date){item in
                    LineMark(
                        x: .value("Date", item.date),
                        y: .value("One Rep Max", item.value)
                    )
                }
            }.frame(maxWidth: .infinity).aspectRatio(1, contentMode: .fit)
        }.padding()
    }
}

#Preview {
    HistoryView()
}
