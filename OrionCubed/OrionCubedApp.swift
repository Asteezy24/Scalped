//
//  OrionCubedApp.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine
import UserNotifications
import CoreData

@main
struct OrionCubedApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @Environment(\.scenePhase) private var scenePhase
    
    let motherView = MotherView(viewRouter: ViewRouter())

    var body: some Scene {
        WindowGroup {
            motherView
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
            default: break
            }
        }
    }
}

//*** Implement App delegate ***//
class AppDelegate: NSObject, UIApplicationDelegate {
    
    private var disposables = Set<AnyCancellable>()
    private var networkManager = NetworkManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerForPushNotifications()
        
        // Check if launched from notification
        let notificationOption = launchOptions?[.remoteNotification]
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        // 1
        if let notification = notificationOption as? [String: AnyObject], let _ = notification["aps"] as? [String: AnyObject] {}
        
        return true
    }
    //No callback in simulator
    //-- must use device to get valid push token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        UserDefaults.standard.setValue(deviceToken.hexString, forKey: "CurrentDeviceToken")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for notifications " + error.localizedDescription)
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(
                options: [.alert, .sound, .badge]) { [weak self] granted, _ in
                guard granted else { return }
                self?.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
