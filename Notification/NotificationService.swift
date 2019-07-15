//
//  NotificationService.swift
//  Notification
//
//  Created by mac user on 2019/07/07.
//  Copyright © 2019 Ryutaro Tada. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            contentHandler(bestAttemptContent)
        }
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests) in
            print("==========didReceive Pending Notification============")
            print(requests)
            
        }
        let center2 = UNUserNotificationCenter.current()
        center2.getDeliveredNotifications { (notifications) in
            print("==========didReceive Delivered Notification============")
            print(notifications)
        }
        print("push受信")
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
