//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 12/5/24.
//

import SwiftUI

struct MainView: View {
    @AppStorage("UserCreationScreenShown")
    var UserCreationScreenShown: Bool = false
    
    var body: some View {
        if !UserCreationScreenShown{
            UserSetup()
        }else{
            TabView{
                Tab("History", systemImage: "chart.line.uptrend.xyaxis"){
                    HistoryView()
                }
                Tab("Workouts", systemImage: "figure.strengthtraining.traditional"){
                    WorkoutsView()
                }
                Tab("User Settings", systemImage: "gearshape"){
                    SettingsView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
