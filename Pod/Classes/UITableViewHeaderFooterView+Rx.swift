//
//  UITableViewHeaderFooterView+Rx.swift
//  Pods
//
//  Created by sergdort on 5/11/16.
//
//

import UIKit
import ObjectiveC
import RxSwift

extension UITableViewHeaderFooterView: SelfAware {
    @objc
    func rx_prepareForReuse() {
        self.rx_prepareForReuse()
        rx_reusableDisposeBag = DisposeBag()
    }
    
    public class func swizzle() {
        // make sure this isn't a subclass
        guard self === UITableViewHeaderFooterView.self else { return }
        
        self.swizzleMethodForSelector(#selector(self.prepareForReuse),
                                      withMethodForSelector: #selector(self.rx_prepareForReuse))
    }
    
    public static func awake() {
        UITableViewHeaderFooterView.swizzle()
    }
}
