//
//  NotificationManager.swift
//  HQueue
//
//  Created by Faridho Luedfi on 13/12/19.
//  Copyright © 2019 Apple Dev. Academy. All rights reserved.
//

import UIKit
import UserNotifications

enum ActionIdentifiersNotif {
  static let updateQueueCategory = "UPDATE_QUEUE"
  static let userEmailVerified = "USER_EMAIL_VERIFIED"
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: Notification Center
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
            
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            let updateQueueCategory = UNNotificationCategory(
                identifier: ActionIdentifiersNotif.updateQueueCategory, actions: [],
              intentIdentifiers: [], options: [])

            UNUserNotificationCenter.current()
              .setNotificationCategories([updateQueueCategory])
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        UserDefaults.standard.set(token, forKey: UserEnv.deviceToken.rawValue)
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaults.standard.removeObject(forKey: UserEnv.deviceToken.rawValue)
        print("Device token log: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(#function)
        completionHandler([.badge,.sound,.alert])
    }
    
    func handleActionNotification(_ data: [String : AnyObject]) {
        print(#function, data)
        if let action = data["category"] as? String {
            
            UIApplication.shared.applicationIconBadgeNumber = 0

            switch action {
            case ActionIdentifiersNotif.updateQueueCategory:
                NotificationCenter.default.post(name: NSNotification.Name(ActionIdentifiersNotif.updateQueueCategory), object: nil, userInfo: nil)
            case ActionIdentifiersNotif.userEmailVerified:
                UserDefaults.standard.set(true, forKey: UserEnv.authVerify.rawValue)
            default:
                break
            }

        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(#function, "silent notif")
        guard let data = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        
        handleActionNotification(data)
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function, response)

        let userInfo = response.notification.request.content.userInfo
        
        if let data = userInfo["aps"] as? [String: AnyObject] {
          handleActionNotification(data)
        }
        
    }
}
