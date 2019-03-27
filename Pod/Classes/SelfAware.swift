//
//  SelfAware.swift
//  Cell+Rx
//
//  Created by Nuno Antunes on 13/11/2017.
//

import Foundation

public protocol SelfAware: class {
    static func awake()
}

class SwizzlingMagic {
    
    private static let doOnce: Any? = {
        _harmlessFunction()
    }()
    
    static func harmlessFunction() {
        _ = SwizzlingMagic.doOnce
    }
    
    private static func _harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate()
    }
}

extension UIApplication {
    
    private static let runOnce: Void = {
        SwizzlingMagic.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
    
}
