//
//  UIHelper.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 12/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation
import UIKit

class UIHelper {
    class Color {
        static let whiteColor = UIColor.white
        static let whiteSmokeColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        static let pictalioBlueColor = UIColor(red: 69 / 255, green: 137 / 255, blue: 150 / 255, alpha: 1)
    }
    
    enum DeviceTypeHeight : Int{
        case iphone5 = 1136
        case iphone6 = 1334
        case iphone6Plus = 1920
        case iphoneX = 2436
        case iphoneXSMax = 2688
        case iphoneXR = 1792
    }
    
    class func getDeviceHeight() -> Int {
        return Int(UIScreen.main.nativeBounds.height)
    }
    
    class func isDeviceType(deviceType: DeviceTypeHeight) -> Bool {
        let height = getDeviceHeight()
        return (deviceType.rawValue == height)
    }
    
    class func isAtLeastDeviceType(deviceType: DeviceTypeHeight) -> Bool {
        let height = getDeviceHeight()
        return (height >= deviceType.rawValue)
    }
    
    class func loadNavigationBarStyle(_ navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.isOpaque = true
        navigationController.navigationBar.barTintColor = Color.whiteColor
    }
}
