//
//  Single.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SingleCityViewController: UIViewController {
    var viewModel: SingleCityViewModel!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pairsTableView: UITableView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bind()
    }
    
    private func bind() {
        self.viewModel.temperature()
            .observeOn(MainScheduler.instance)
            .bind(to: self.label.rx.text)
            .disposed(by: self.bag)
        
        self.viewModel.humidity()
            .observeOn(MainScheduler.instance)
            .bind(to: self.humidityLabel.rx.text)
            .disposed(by: self.bag)
        
        self.viewModel.pairs
            .asDriver()
            .drive(self.pairsTableView.rx.items(cellIdentifier: "pairCell")) { (index, pair, cell) in
                cell.textLabel?.text = "\(pair.first) - \(pair.second)"
            }.disposed(by: self.bag)
        
        self.pairsTableView.rx.modelSelected(Pair.self).subscribe(onNext: { [weak self] pair in
            guard let strongSelf = self else { return }
            
            if let selectedIndexPath = strongSelf.pairsTableView.indexPathForSelectedRow {
                strongSelf.pairsTableView.deselectRow(at: selectedIndexPath, animated: true)
            }
            
            let alert = UIAlertController(title: "Edit pair", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { $0.text = pair.first; $0.tag = 1 })
            alert.addTextField(configurationHandler: { $0.text = pair.second; $0.tag = 2 })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                guard
                    let newFirst = alert.textFields?.first(where: { $0.tag == 1 })?.text,
                    let newSecond = alert.textFields?.first(where: { $0.tag == 2 })?.text
                    else { return }
                
                strongSelf.viewModel.update(pair: pair, newFirst: newFirst, newSecond: newSecond)
            }))
            
            strongSelf.present(alert, animated: true, completion: nil)
        }).disposed(by: self.bag)
    }
    
    @IBAction func onReloadTap(_ sender: UIButton) {
        self.viewModel.reload()
        self.bind()
    }
}
