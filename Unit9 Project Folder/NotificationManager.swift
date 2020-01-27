//
//  NotificationManager.swift
//  Unit9 Project Folder
//
//  Created by Joseph Heydorn on 1/20/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    init() {
        self.requestNotificationAuthorization()
    }
    
    func requestNotificationAuthorization() {
        let authOption = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOption) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification(second: Int) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Hey there!"
        notificationContent.body = "This is a local test notification."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(second), repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
