//
//  StateManager.swift
//  GKOG
//
//  Created by Suji Lee on 12/5/23.
//

import Foundation

class StateManager: ObservableObject {
    
    static let shared = StateManager()

    //User State
    @Published private var _userLoggedIn: Bool = false
    @Published private var _userAgreed: Bool = false
    @Published private var _userRegistered: Bool = false
    @Published private var _userLoggedOut: Bool = false
    @Published private var _userDeleted: Bool = false
    
    @Published private var _tokenExpired: Bool = false
    @Published private var _serverDowned: Bool = false
    
    var userLoggedIn: Bool {
        get {
            return self._userLoggedIn
        }
        set {
            self._userLoggedIn = newValue
        }
    }
    
    var userAgreed: Bool {
        get {
            return self._userAgreed
        }
        set {
            self._userAgreed = newValue
        }
    }
    
    var userRegistered: Bool {
        get {
            return self._userRegistered
        }
        set {
            self._userRegistered = newValue
        }
    }
    
    var userLoggedOut: Bool {
        get {
            return self._userLoggedOut
        }
        set {
            self._userLoggedOut = newValue
        }
    }
    
    var userDeleted: Bool {
        get {
            return self._userDeleted
        }
        set {
            self._userDeleted = newValue
        }
    }
    
    var tokenExpired: Bool {
        get {
            return self._tokenExpired
        }
        set {
            self._tokenExpired = newValue
       }
    }
    
    var serverDowned: Bool {
        get {
            return self._serverDowned
        }
        set {
            self._serverDowned = newValue
        }
    }

    init() {}
}
