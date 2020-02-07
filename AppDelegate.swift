//
//  AppDelegate.swift
//  Restaurant
//
//  Created by Mikhail Ladutska on 1/30/20.
//  Copyright © 2020 Mikhail Ladutska. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        MenuController.shared.loadOrder()
        MenuController.shared.loadItems()
        MenuController.shared.loadRemoteData()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        MenuController.shared.saveOrder()
        MenuController.shared.saveItems()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25000000, diskCapacity: 50000000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

