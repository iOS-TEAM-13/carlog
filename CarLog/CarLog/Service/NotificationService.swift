//
//  NotificationService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/30.
//

import Foundation
import UserNotifications

class NotificationService {
    static let service = NotificationService()
    
    private init() { }
    
    func setAuthorization() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in }
        )
    }
}
