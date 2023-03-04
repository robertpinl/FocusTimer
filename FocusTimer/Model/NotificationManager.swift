//
//  NotificationManager.swift
//  FocusTimer
//
//  Created by Robert P on 04.03.2023.
//

import Foundation
import UserNotifications

final class NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func showTimerWentOff() {
        let content = UNMutableNotificationContent()
        content.title = "Focus Timer"
        content.subtitle = "Your focus timer went off!"
//        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
