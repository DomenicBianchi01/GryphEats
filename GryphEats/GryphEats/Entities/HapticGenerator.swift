//
//  HapticGenerator.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-21.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation
import UIKit

// MARK: - HapticGenerator

class HapticGenerator {
    
    // MARK: FeedbackStyle
    
    enum FeedbackStyle {
        case light
        case medium
        case heavy
        
        case error
        case success
        case warning
        
        // MARK: Fileprivate
        
        fileprivate var impactType: UIImpactFeedbackGenerator.FeedbackStyle? {
            if self == .light {
                return .light
            } else if self == .medium {
                return .medium
            } else if self == .heavy {
                return .heavy
            }
            
            return nil
        }
        
        fileprivate var notificationType: UINotificationFeedbackGenerator.FeedbackType? {
            if self == .success {
                return .success
            } else if self == .warning {
                return .warning
            } else if self == .error {
                return .error
            }
            
            return nil
        }
    }
    
    // MARK: Lifecycle
    
    init(feedbackStyle: FeedbackStyle) {
        self.feedbackStyle = feedbackStyle
    }
    
    // MARK: Internal
    
    func prepare() {
        if let impactType = feedbackStyle.impactType {
            generator = UIImpactFeedbackGenerator(style: impactType)
        } else {
            generator = UINotificationFeedbackGenerator()
        }
        
        generator?.prepare()
    }
    
    /// Must call `prepare()` prior to calling this function; otherwise, no feedback will be generated
    func generate() {
        if let notificationType = feedbackStyle.notificationType,
            let generator = generator as? UINotificationFeedbackGenerator
        {
            generator.notificationOccurred(notificationType)
        } else if let generator = generator as? UIImpactFeedbackGenerator {
            generator.impactOccurred()
        }
    }
    
    // MARK: Private
    
    private var generator: UIFeedbackGenerator? = nil
    private let feedbackStyle: FeedbackStyle
    
}
