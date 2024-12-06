//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 12/5/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            Tab("Workouts", systemImage: "figure.strengthtraining.traditional"){
                WorkoutsView()
            }
            Tab("User Settings", systemImage: "gearshape"){
                SettingsView()
            }
        }.modelContainer(for: Workout.self)
    }
}

#Preview {
    MainView()
}
