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

extension UITableViewHeaderFooterView {    
    func rx_prepareForReuse() {
        self.rx_prepareForReuse()
        rx_reusableDisposeBag = DisposeBag()
    }
    
    open override class func initialize() {
        // make sure this isn't a subclass
        if self !== UITableViewHeaderFooterView.self {
            return
        }
      
        self.swizzleMethodForSelector(#selector(self.prepareForReuse),
            withMethodForSelector: #selector(self.rx_prepareForReuse))
    }
}
