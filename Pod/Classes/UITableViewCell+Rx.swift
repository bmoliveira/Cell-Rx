import UIKit
import RxSwift
import ObjectiveC

public extension UITableViewCell {
    
    func rx_prepareForReuse() {
        self.rx_prepareForReuse()
        rx_reusableDisposeBag = DisposeBag()
    }
    
    open override class func initialize() {
        // make sure this isn't a subclass
        if self !== UITableViewCell.self {
            return
        }
      
        self.swizzleMethodForSelector(#selector(self.prepareForReuse),
            withMethodForSelector: #selector(self.rx_prepareForReuse))
    }
}
