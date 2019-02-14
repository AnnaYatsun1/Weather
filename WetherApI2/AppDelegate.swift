//
//  AppDelegate.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 14/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let session = URLSession.init(configuration: .default)

        let countriesNetworkService = CountriesNetworkService(session: session)
        let weatherNetworkService = WeatherNetworkService(session: session)
        let rootViewController = CountriesViewController(countriesManager: countriesNetworkService, weatherManager: weatherNetworkService)
        
        let navigationController = UINavigationController(rootViewController: rootViewController)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
        return true

    }

}

