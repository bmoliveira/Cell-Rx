//
//  DisposeBagReusable.swift
//  Pods
//
//  Created by sergdort on 5/13/16.
//
//

import UIKit
import RxSwift

func lockWith(_ object: AnyObject, closure: (Void) -> Void) {
    objc_sync_enter(object); defer { objc_sync_exit(object) }
    closure(())
}

private struct AssociatedKeys {
    static var ReusableDisposeBag = "rx_reusableDisposeBag"
}

public protocol DisposeBagReusable: class {
    var rx_reusableDisposeBag: DisposeBag {get set}
}

extension Reactive where Base : DisposeBagReusable {
  public var reusableDisposeBag: DisposeBag {
    return self.base.rx_reusableDisposeBag
  }
}

extension DisposeBagReusable  {
    public var rx_reusableDisposeBag: DisposeBag {
      @available(swift, deprecated: 4.0, obsoleted: 5.0, renamed: "rx.reusableDisposeBag", message: "This will be removed in v5.0; please migrate to a different API.")
        get {
            var reusableDisposeBag: DisposeBag!
            lockWith(self) {
                let lookup = objc_getAssociatedObject(self, &AssociatedKeys.ReusableDisposeBag) as? DisposeBag
                if let lookup = lookup {
                    reusableDisposeBag = lookup
                } else {
                    let newDisposeBag = DisposeBag()
                    self.rx_reusableDisposeBag = newDisposeBag
                    reusableDisposeBag = newDisposeBag
                }
            }
            return reusableDisposeBag
        }
        set {
            lockWith(self) {
                objc_setAssociatedObject(self, &AssociatedKeys.ReusableDisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

extension UICollectionReusableView: DisposeBagReusable {
}

extension UITableViewCell: DisposeBagReusable {
}

extension UITableViewHeaderFooterView: DisposeBagReusable {
}
