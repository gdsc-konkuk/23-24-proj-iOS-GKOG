//
//  ContentView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//

import SwiftUI
import UIKit

var screenWidth = UIScreen.main.bounds.width
var screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    
    @EnvironmentObject var stateManager: StateManager

    var body: some View {
        MapPage()
//        if !stateManager.userLoggedIn {
//            LoginPage()
//        } else {
//            if !stateManager.userRegistered {
//                AgreementPage()
//            } else {
//                MapPage()
//            }
//        }
    }
}

#Preview {
    ContentView()
}


extension UIApplication {
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
