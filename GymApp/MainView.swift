//
//  MainView.swift
//  GymApp
//
//  Created by Robert Molina on 12/5/24.
//

import SwiftUI

extension UserDefaults{
    var UserCreationScreenShown: Bool{
        get{
            return (UserDefaults.standard.value(forKey: "UserCreationScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "UserCreationScreenShown")
        }
    }
}

struct MainView: View {
    var body: some View {
        if !UserDefaults.standard.UserCreationScreenShown{
            UserSetup()
        }else{
            TabView{
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
