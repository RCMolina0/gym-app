//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 12/5/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @AppStorage("UserCreationScreenShown")
    var UserCreationScreenShown: Bool = false
    @Query var user: [User]
    
    var body: some View {
        if !UserCreationScreenShown{
            UserSetup()
        }else{
            TabView{
                Tab("History", systemImage: "chart.line.uptrend.xyaxis"){
                    HistoryView()
                    if user.first!.isWorkingout(){
                        Text("\(user.first!.getCurrentWorkout()!.name)ing").frame(width: UIScreen.main.bounds.width,height: 50).border(.gray)
                    }
                }
                Tab("Workouts", systemImage: "figure.strengthtraining.traditional"){
                        WorkoutsView()
                    if user.first!.isWorkingout(){
                        Text("\(user.first!.getCurrentWorkout()!.name)ing").frame(width: UIScreen.main.bounds.width,height: 50).border(.gray)
                    }
                }
                Tab("User Settings", systemImage: "gearshape"){
                    SettingsView()
                    if user.first!.isWorkingout(){
                        Text("\(user.first!.getCurrentWorkout()!.name)ing").frame(width: UIScreen.main.bounds.width,height: 50).border(.gray)

                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
