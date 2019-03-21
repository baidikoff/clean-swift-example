//
//  WeatherCitiesViewController.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherCitiesViewController: UITableViewController {
    
    private let coordinator: CleanWeatherCoordinator = appContainer.resolve()
    private let viewModel = WeatherCitiesViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
        self.viewModel.citiesList()
            .observeOn(MainScheduler.instance)
            .bind(to: self.tableView.rx.items(cellIdentifier: "cityCell")) { (_, city, cell) in
                cell.textLabel?.text = city.name
            }.disposed(by: self.bag)
        
        self.tableView.rx
            .modelSelected(WeatherCity.self)
            .subscribe(onNext: { [weak self] city in
                guard let strongSelf = self else { return }
                strongSelf.coordinator.open(city: city)
            }).disposed(by: self.bag)
    }
}
