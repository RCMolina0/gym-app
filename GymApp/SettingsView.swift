//
//  SettingsView.swift
//  GymApp
//
//  Created by Robert Molina on 12/5/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query var user: [User] //saved workouts
    var body: some View {
        Text(user.first!.name)
    }
}

#Preview {
    SettingsView()
}
