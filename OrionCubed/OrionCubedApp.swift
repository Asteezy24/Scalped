//
//  OrionCubedApp.swift
//  OrionCubed
//
//  Created by Alexander Stevens on 11/14/20.
//

import SwiftUI
import Combine
import UserNotifications

@main
struct OrionCubedApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            HomeView()
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
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        let endpoint = Endpoint.sendDeviceId
        let parameterDictionary = [
            "username": "alex",
            "deviceToken" : token
        ]
        
        networkManager.request(type: NetworkResponse.self, requestType: .post, parameters: parameterDictionary, url: endpoint.url, headers: [:])
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let _ = self else { return }
                switch value {
                case .failure:
                    print(value)
                    print("Error in sending device token")
                case .finished:
                    print("Sent value for device token")
                }
            },
            receiveValue: { [weak self] response in
                guard let _ = self else { return }
                print(response)
                
                if !response.error {
                    print("Received response for notification registration")
                }
            })
            .store(in: &disposables)
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("failed to register for notifications")
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
