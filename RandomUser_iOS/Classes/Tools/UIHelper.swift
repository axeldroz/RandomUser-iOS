//
//  UIHelper.swift
//  RandomUser_iOS
//
//  Created by Axel Drozdzynski on 12/05/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import Foundation
import UIKit

class UIHelper {
    class Color {
        static let whiteColor = UIColor.white
        static let whiteSmokeColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
        static let greenSwapcard = UIColor(red: 5 / 255, green: 197 / 255, blue: 125 / 255, alpha: 1)
        static let gray = UIColor(red: 232 / 255, green: 232 / 255, blue: 232 / 255, alpha: 1)
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
    
    class func getURLFromPath(_ path: String) -> URL {
        let imgPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        return URL.init(string: imgPath)!
    }
}
