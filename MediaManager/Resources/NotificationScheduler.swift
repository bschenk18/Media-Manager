//
//  NotificationScheduler.swift
//  MediaManager
//
//  Created by Benjamin Prentiss on 1/12/23.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotifications(mediaItem: MediaItem) {
        guard let reminderDate = mediaItem.reminderDate,
              let identifier = mediaItem.id?.uuidString else { return }

        clearNotifications(mediaItem: mediaItem)

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget to watch \(mediaItem.title ?? "--missing movie/show title--")"
        content.sound = .default
        content.categoryIdentifier = "MediaItemNotification"

        let fireDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notification request, \(error.localizedDescription)")
            }
        }
    }
    
    func clearNotifications(mediaItem: MediaItem) {
        guard let identifier = mediaItem.id?.uuidString else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
