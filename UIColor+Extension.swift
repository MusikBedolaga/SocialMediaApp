//
//  UIColor+Exception.swift
//  SocialMediaApp
//
//  Created by Муса Зарифянов on 08.11.2024.
//

import Foundation
import UIKit


extension UIColor {
    static let customRed = UIColor(hex: 0x782048)
    static let lightBlue = UIColor(hex: 0xE6EEFA)
    static let customLightGray = UIColor(hex: 0xFFFFFF)
    static let customBlue = UIColor(hex: 0x1D2860)
}

extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex >> 16) & 0xff) / 255.0
        let green = CGFloat((hex >> 8) & 0xff) / 255.0
        let blue = CGFloat(hex & 0xff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
