//
//  GymAppApp.swift
//  GymApp
//  officially made
//  Created by Robert Molina on 11/25/24.
//

import SwiftUI

@main
struct GymAppApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }.modelContainer(for: User.self)
    }
}


