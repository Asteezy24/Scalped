//
//  OrionCubedApp.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import UserNotifications

@main
struct OrionCubedApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}

//*** Implement App delegate ***//
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerForPushNotifications()
        return true
    }
    //No callback in simulator
    //-- must use device to get valid push token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)          {
        print(deviceToken)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func registerForPushNotifications() {
        //1
        UNUserNotificationCenter.current()
            //2
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                //3 User registered for notifications
                print("Permission granted: \(granted)")
            }
    }
}
