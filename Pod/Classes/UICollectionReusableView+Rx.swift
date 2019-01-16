import UIKit
import RxSwift
import ObjectiveC

extension UICollectionReusableView: SelfAware {
    
    @objc
    func rx_prepareForReuse() {
        self.rx_prepareForReuse()
        rx_reusableDisposeBag = DisposeBag()
    }
    
    public class func swizzle() {
        // make sure this isn't a subclass
        guard self === UICollectionReusableView.self else { return }

        self.swizzleMethodForSelector(#selector(self.prepareForReuse),
                                      withMethodForSelector: #selector(self.rx_prepareForReuse))
    }
    
    public static func awake() {
        UICollectionReusableView.swizzle()
    }
}
