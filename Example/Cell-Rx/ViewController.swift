//
//  ViewController.swift
//  Cell-Rx
//
//  Created by Ivan Bruel on 03/07/2016.
//  Copyright (c) 2016 Ivan Bruel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cell_Rx

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  let disposeBag = DisposeBag()

  let viewModels: Variable<[ViewModel]> = Variable<[ViewModel]>([])

  override func viewDidLoad() {
    super.viewDidLoad()
    for _ in 0..<100 {
      viewModels.value.append(ViewModel())
    }
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    viewModels
      .asObservable()
      .bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell", cellType: UITableViewCell.self)) {
        (row, element,cell) in
  
        guard let textLabel = cell.textLabel else {
          return
        }
        
        element.string
          .asObservable()
          .debug()
          .bind(to: textLabel.rx.text)
          .disposed(by: cell.rx.reusableDisposeBag)
  
      }.disposed(by: disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
