//
//  NSObject+Swizzle.swift
//  Pods
//
//  Created by sergdort on 5/11/16.
//
//

import Foundation
import ObjectiveC

internal var swizzeledClasses: [AnyClass] = []

extension NSObject {
    class func swizzleMethodForSelector(_ originalSelector: Selector,
                                        withMethodForSelector swizzledSelector: Selector) {
        if swizzeledClasses.contains(where: { $0 === self }) {
            return
        } else {
            swizzeledClasses.append(self)
        }
      
        guard let originalMethod = class_getInstanceMethod(self, originalSelector)
            else { fatalError("Unrecognized selector \(originalSelector) on \(self)") }
        guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            else { fatalError("Unrecognized selector \(swizzledSelector) on \(self)") }
        
        let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}
