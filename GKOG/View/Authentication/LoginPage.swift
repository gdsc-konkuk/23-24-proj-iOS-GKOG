//
//  LoginPage.swift
//  GKOG
//
//  Created by Suji Lee on 12/5/23.
//

import SwiftUI

struct LoginPage: View {
    
    var body: some View {
        Button(action: {
            StateManager.shared.userLoggedIn = true
            print(StateManager.shared.userLoggedIn)
        }, label: {
            Text("Login")
        })
    }
}

#Preview {
    LoginPage()
}
