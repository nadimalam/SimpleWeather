//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Nadim Alam on 09/02/2019.
//  Copyright © 2019 Nadim Alam. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setNavigationBar()
        setupDefaultSettings()
        return true
    }
    
    private func setNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.navBarColor
        UINavigationBar.appearance().tintColor = .white // Changes the back button text color.
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupDefaultSettings() {
        let userDefaults = UserDefaults.standard
        // Only save the initial value if it hasnt already been persisted.
        if userDefaults.value(forKey: "unit") == nil {
            userDefaults.set(Unit.celsius.rawValue, forKey: "unit")
        }
    }
}
