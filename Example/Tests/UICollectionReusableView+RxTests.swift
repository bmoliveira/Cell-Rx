//
//  UICollectionReusableView+RxTests.swift
//  Cell-Rx
//
//  Created by Segii Shulga on 5/13/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import XCTest
import UIKit
import RxSwift
import Cell_Rx

class UICollectionReusableView_RxTests: XCTestCase {

    func test_that_it_has_dispose_bag_by_default() {
        let view = UICollectionReusableView(frame: CGRect.zero)
        
        XCTAssertNotNil(view.rx.reusableDisposeBag)
    }
    
    func test_that_it_returns_set_dispose_bag() {
        let view = UICollectionReusableView(frame: CGRect.zero)
        let disposeBag = DisposeBag()
        view.rx_reusableDisposeBag = disposeBag
        
        XCTAssertTrue(view.rx.reusableDisposeBag === disposeBag)
    }
    
    func test_that_it_changes_dispose_bag_on_reuse() {
        let view = UICollectionReusableView(frame: CGRect.zero)
        let disposeBag = DisposeBag()
        view.rx_reusableDisposeBag = disposeBag
        view.prepareForReuse()
        
        XCTAssertTrue(view.rx.reusableDisposeBag !== disposeBag)
    }
}
