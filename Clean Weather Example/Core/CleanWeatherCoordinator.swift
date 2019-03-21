//
//  CleanWeatherCoordinator.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import UIKit

class CleanWeatherCoordinator {
    private let rootController: UINavigationController
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    func open(city: WeatherCity) {
        guard let controller = self.createController(fromStoryboard: "Main", withIdentifier: "singleCityController") as? SingleCityViewController else { return }

        let viewModel = SingleCityViewModel(city: city)
        controller.viewModel = viewModel

        self.rootController.pushViewController(controller, animated: true)
    }
    
    private func createController<ControllerType: UIViewController>(fromStoryboard storyboard: String, withIdentifier identifier: String) -> ControllerType? {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier) as? ControllerType
    }
}
