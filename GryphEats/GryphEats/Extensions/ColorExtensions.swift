//
//  ColorExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Color

extension Color {
    
    // MARK: Internal
    
    static func lightGray(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 25/255, green: 25/255, blue: 25/255)
        } else {
            return Color(red: 245/255, green: 245/255, blue: 245/255)
        }
    }
    
    static func guelphRed(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 227/255, green: 5/255, blue: 56/255)
        } else {
            return Color(red: 194/255, green: 4/255, blue: 48/255)
        }
    }
    
    static func cardBackground(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 75/255, green: 75/255, blue: 75/255)
        } else {
            return .white
        }
    }
    
    static func tabBarBackground(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 25/255, green: 25/255, blue: 25/255)
        } else {
            return .white
        }
    }
    
    static func navigationGuelphYellow(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 25/255, green: 25/255, blue: 25/255)
        } else {
            return guelphYellow
        }
    }
    
    /// For light mode, returns `.black`. For dark mode, returns `.white`.
    static func darkModeBlack(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return .white
        } else {
            return .black
        }
    }
    
    static func textFieldColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return Color(red: 25/255, green: 25/255, blue: 25/255)
        } else {
            return Color(red: 230/255, green: 230/255, blue: 230/255)
        }
    }
    
    static let guelphYellow = Color(red: 255/255, green: 199/255, blue: 42/255)
    
}

// MARK: - UIColor

extension UIColor {
    
    // MARK: Internal
    
    static let guelphYellow = UIColor(red: 255/255, green: 199/255, blue: 42/255, alpha: 1)
    
    static let lightGray = UIColor { traits in
        if traits.userInterfaceStyle == .dark {
            return UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
        } else {
            return UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        }
    }
    
    static let cardBackground = UIColor { traits in
        if traits.userInterfaceStyle == .dark {
            return UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1)
        } else {
            return .white
        }
    }
}
