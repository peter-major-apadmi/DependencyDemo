//
//  Settings.swift
//  DependencyDemo
//
//  Created by Peter Major on 18/03/2021.
//

import Foundation

protocol Settings: AnyObject {
    var userName: String? { get set }
}

class SettingsImpl: Settings {
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    var userName: String? {
        get { return userDefaults.string(forKey: Keys.userName.rawValue) }
        set {
            if let userName = newValue {
                userDefaults.setValue(userName, forKey: Keys.userName.rawValue)
            } else {
                userDefaults.removeObject(forKey: Keys.userName.rawValue)
            }
        }
    }

    private enum Keys: String {
        case userName
    }
}
