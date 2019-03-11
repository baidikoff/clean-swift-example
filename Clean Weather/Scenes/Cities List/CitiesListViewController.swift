//
//  CitiesListViewController.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 2/18/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class CitiesListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var text: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    private let viewModel: CitiesListViewModel = container.resolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clear()
        self.bind()
    }
    
    private func clear() {
        self.text.text = ""
    }
    
    private func bind() {
        self.viewModel
            .citiesListString()
            .observeOn(MainScheduler.instance)
            .bind(to: self.text.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel
            .citiesListErrorIndicator()
            .observeOn(MainScheduler.instance)
            .bind { _ in
                let alert = UIAlertController(title: "Error", message: "Error on loading", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }.disposed(by: self.disposeBag)
        
        self.retryButton.rx.tap.subscribe { event in
            print("did tap")
        }.disposed(by: self.disposeBag)
    }
}

protocol CitiesListViewModel {
    func citiesListString() -> Observable<String>
    func citiesListErrorIndicator() -> Observable<Bool>
}

struct CitiesListViewModelImpl: CitiesListViewModel {
    private let getCitiesUseCase: GetCitiesListUseCase = container.resolve()
    private let citiesList: Observable<[WeatherCity]>
    
    init() {
        self.citiesList = self.getCitiesUseCase.action().asObservable().retr
    }
    
    func citiesListString() -> Observable<String> {
        return self.citiesList
            .map { $0.isEmpty ? "" : "\($0)" }
            .asObservable()
    }
    
    func citiesListErrorIndicator() -> Observable<Bool> {
        return self.citiesList
            .catchErrorJustReturn([])
            .map { $0.isEmpty }
            .filter { $0 }
            .asObservable()
    }
}
