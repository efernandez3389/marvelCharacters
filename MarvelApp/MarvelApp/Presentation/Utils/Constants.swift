//
//  Constants.swift
//  MarvelApp
//
//  Created by Estefania Fernandez on 22/4/22.
//

import Foundation
import UIKit

struct Constants {
    struct Size {
        static let height: CGFloat = 130
        static let width: CGFloat = 175
        static let navigationBarHeight: CGFloat = 100
        static let scrollViewOffset: CGFloat = 180
    }
    
    struct Spacing {
        static let none: CGFloat = 0
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
    }
    
    struct FontSize {
        static let small: CGFloat = 12
        static let medium: CGFloat = 18
        static let large: CGFloat = 30
    }
    
    struct Color {
        static let background = UIColor(red: 226.0/255, green: 0/255, blue: 26/255, alpha: 1.0)
        static let lightBackground = UIColor.white
        static let lightText = UIColor.white
    }
}
