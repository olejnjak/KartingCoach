//
//  Colors.swift
//  KartingCoach
//
//  Created by Jakub Olejník on 10/09/2017.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt32) {
        self.init(
            red: CGFloat(Double((hex & 0xFF0000) >> 16) / 255.0),
            green: CGFloat(Double((hex & 0xFF00) >> 8) / 255.0),
            blue: CGFloat(Double(hex & 0xFF) / 255.0),
            alpha: 1.0
        )
    }
    
    convenience init(hexString: String) {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = hexString.hasPrefix("#") ? 1 : 0 // bypass '#' character
        scanner.scanHexInt32(&rgbValue)
        self.init(hex: rgbValue)
    }
}

extension UIColor {
    static var bestTime: UIColor {
        return UIColor(hue: 145.0/255, saturation: 77.0/255, brightness: 80.0/255, alpha: 0.2)
    }
}
