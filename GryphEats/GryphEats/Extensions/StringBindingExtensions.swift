//
//  StringBindingExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-11.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

import AWSTranslate

var credentialsProvider = AWSStaticCredentialsProvider(accessKey: AWSKeys.accessKey, secretKey: AWSKeys.secretKey)
var configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)


// MARK: - StringBindingExtensions

extension Optional where Wrapped == String {
    
    // MARK: Internal
    
    /// When the binding contains an optional string, this property will either return the value or an empty string (if the actual value of the binding is `nil`)
    var safelyUnwrapped: String {
        get {
            return self ?? ""
        }
        set {
            self = newValue.isEmpty ? nil : newValue
        }
    }
}

extension String {

    public func translateText() -> String {
        
        var toReturn: String = self
        
        if (Locale.current.languageCode != "en" && configuration != nil) {
            let myGroup = DispatchGroup()
            myGroup.enter()
            
            let translateClient = AWSTranslate.default()
            let translateRequest = AWSTranslateTranslateTextRequest()
            translateRequest?.sourceLanguageCode = "en"
            translateRequest?.targetLanguageCode = Locale.current.languageCode
            
            translateRequest?.text = toReturn
            let task = translateClient.translateText(translateRequest!)
            task.continueWith(block: { task in
                guard let response = task.result else {
                    print("Got error \(String(describing: task.error))")
                    myGroup.leave()
                    return task.error
                }
                
                if let translatedText = response.translatedText {
                    toReturn = translatedText
                    print (translatedText)
                    myGroup.leave()
                    return translatedText
                }
                myGroup.leave()
                return nil
            })
            
            myGroup.wait()
        }
        return toReturn
    }
}
