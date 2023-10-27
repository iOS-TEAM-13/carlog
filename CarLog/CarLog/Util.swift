//
//  Util.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/20.
//

import UIKit

class Util {
    static let util = Util()
    
    // TabBar
    static func mainTabBarController() -> UITabBarController {
        let tabBarController = TabBarController()

        let tabs: [(root: UIViewController, icon: String)] = [
            (MyCarPageViewController(), "car"),
            (HistoryPageViewController(), "book"),
            //        (MapPageViewController(), "map"),
            //        (CommunityPageViewController(), "play"),
            (MyPageViewController(), "person"),
        ]

        tabBarController.setViewControllers(tabs.map { root, icon in
            let navigationController = UINavigationController(rootViewController: root)
            let tabBarItem = UITabBarItem(title: nil, image: .init(systemName: icon), selectedImage: .init(systemName: "\(icon).fill"))
            navigationController.tabBarItem = tabBarItem
            return navigationController
        }, animated: false)

        return tabBarController
    }

    // MARK: MyCarPage

    func toInterval(seletedDate: Int, type: componentsType) -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        var value = 0
        switch type {
        case .engineOil:
            value = 6 - seletedDate
        case .missionOil:
            value = 24 - seletedDate
        case .brakeOil:
            value = 24 - seletedDate
        case .brakePad:
            value = 12 - seletedDate
        case .tireRotation:
            value = 12 - seletedDate
        case .tire:
            value = 36 - seletedDate
        case .fuelFilter:
            value = 12 - seletedDate
        case .wiperBlade:
            value = 12 - seletedDate
        case .airconFilter:
            value = 12 - seletedDate
        case .insurance:
            value = 12 - seletedDate
        }
        guard let newDate = calendar.date(byAdding: .month, value: value, to: currentDate) else { return Date() }
        return newDate
    }
    
    func toInterval(seletedDate: Int) -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        guard let newDate = calendar.date(byAdding: .month, value: -seletedDate, to: currentDate) else { return Date() }
        return newDate
    }
    
    func toInterval(seletedInsuranceDate: Int) -> (Date, Date) {
        let calendar = Calendar.current
        let currentDate = Date()
        var thisYearComponents = DateComponents()
        thisYearComponents.year = calendar.component(.year, from: currentDate)
        thisYearComponents.month = seletedInsuranceDate
        thisYearComponents.day = 1
        
        var lastYearComponents = DateComponents()
        lastYearComponents.year = calendar.component(.year, from: currentDate) - 1
        lastYearComponents.month = seletedInsuranceDate
        lastYearComponents.day = 1
        
        var nextYearComponents = DateComponents()
        nextYearComponents.year = calendar.component(.year, from: currentDate) + 1
        nextYearComponents.month = seletedInsuranceDate
        nextYearComponents.day = 1
        
        guard let thisYearDate = calendar.date(from: thisYearComponents) else { return (Date(), Date()) }
        guard let lastYearDate = calendar.date(from: lastYearComponents) else { return (Date(), Date()) }
        guard let nextYearDate = calendar.date(from: nextYearComponents) else { return (Date(), Date()) }
        
        if currentDate < thisYearDate {
            return (lastYearDate, thisYearDate)
        } else {
            return (thisYearDate, nextYearDate)
        }
    }
    
    func calculatorProgress(firstInterval: String, secondInterval: String) -> Double {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let first = firstInterval.intervalToDate() else { return 0.0 }
        guard let second = secondInterval.intervalToDate() else { return 0.0 }

        let totalProgress = calendar.dateComponents([.day], from: first, to: second)
        let currentProgress = calendar.dateComponents([.day], from: first, to: currentDate)
        guard let firstDays = totalProgress.day else { return 0.0 }
        guard let secoundDays = currentProgress.day else { return 0.0 }
        
        return Double(secoundDays) / Double(firstDays)
    }
    
    func calculatorProgress(firstInsurance: String, secondInsurance: String) -> Double {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let first = firstInsurance.intervalToDate() else { return 0.0 }
        guard let second = secondInsurance.intervalToDate() else { return 0.0 }

        let totalProgress = calendar.dateComponents([.day], from: first, to: second)
        let currentProgress = calendar.dateComponents([.day], from: first, to: currentDate)

        guard let firstDays = totalProgress.day else { return 0.0 }
        guard let secoundDays = currentProgress.day else { return 0.0 }
        return Double(secoundDays) / Double(firstDays)
    }
}
