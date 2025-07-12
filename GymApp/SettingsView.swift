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
    @State var editName: String = ""
    var body: some View {
        VStack{
            Text("Hello \(user.first!.name)!")
                .font(.headline)
            Spacer()
            HStack {
                TextField(user.first!.name, text: $editName)
                Button("Change Name"){
                    user.first!.name = editName
                    editName = ""
                }
            }.padding()
        }.padding(.vertical)
    }
}

#Preview {
    SettingsView()
}
