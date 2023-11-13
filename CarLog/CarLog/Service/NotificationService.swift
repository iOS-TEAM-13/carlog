//
//  NotificationService.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/30.
//

import UIKit

import FirebaseAuth
import UserNotifications

class NotificationService {
    static let service = NotificationService()
    
    private init() { }
    
    func setAuthorization(completion: @escaping () -> Void) {
        let authOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if granted {
                
            } else {
                completion()
            }
        }
    }
    
    func pushNotification(part: PartsInfo) {
        let month = {
            switch part.name {
            case .engineOil: return 3
            case .missionOil: return 6
            case .brakeOil: return 6
            case .brakePad: return 3
            case .tire: return 3
            case .tireRotation: return 12
            case .fuelFilter: return 3
            case .wiperBlade: return 3
            case .airconFilter: return 3
            case .insurance: return 3
            }
        }()
        
        FirestoreService.firestoreService.loadCarPart { carParts in
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "\(part.name.rawValue)의 교체 알림"
            notificationContent.body = "교체 시기가 \(month)개월 남았습니다!"
            notificationContent.sound = .default
            
            let targetDate = part.startTime
            var alarmDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: targetDate ?? Date())
            alarmDateComponents.hour = 9
            alarmDateComponents.minute = 0
            alarmDateComponents.second = 0
            if (alarmDateComponents.month ?? 0) + month > 12 {
                alarmDateComponents.month = (alarmDateComponents.month ?? 0) + month - 12
                alarmDateComponents.year = (alarmDateComponents.year ?? 0) + 1
            } else {
                alarmDateComponents.month = (alarmDateComponents.month ?? 0) + month
            }
            let trigger = UNCalendarNotificationTrigger(dateMatching: alarmDateComponents , repeats: false)
            guard let email = Constants.currentUser.userEmail else { return }
            let request = UNNotificationRequest(identifier: "\(email)+\(part.name)", content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
}
