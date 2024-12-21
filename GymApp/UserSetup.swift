//
//  UserSetup.swift
//  GymApp
//
//  Created by Robert Molina on 12/18/24.
//

import SwiftUI

struct UserSetup: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context //needed to save and remove workouts
    @State var UserName: String = ""
    var body: some View {
        ZStack{
            VStack{
                Text("Hello! Welcome to GymApp!")
                HStack{
                    Text("Please enter your name")
                    TextField("Name", text: $UserName)
                }
                Spacer()
                Button("Done"){
                    if(UserName != ""){
                        context.insert(User(name: UserName))
                        UserDefaults.standard.set(true, forKey: "UserCreationScreenShown")
                        dismiss()
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    UserSetup()
}
