//
//  AppDelegate.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import UIKit
import Apollo
import DITranquillity

let appContainer = DIContainer()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initDI()
        self.openRootScreen()

        return true
    }

    private func initDI() {
        appContainer.register(self.buildApolloClient)
        appContainer.register(WeatherCitiesRepository.init)
        appContainer.register(SingleCityRepository.init)
        appContainer.register(GraphQLRepository.init)
    }
    
    private func buildApolloClient() -> ApolloClient {
        let wsEndpointURL = URL(string: "wss://subscriptions.graph.cool/v1/cjt728qsx272o01829kerhgj2")!
        let endpointURL = URL(string: "https://api.graph.cool/simple/v1/cjt728qsx272o01829kerhgj2")!
        let websocket = WebSocketTransport(request: URLRequest(url: wsEndpointURL))
        
        let splitNetworkTransport = SplitNetworkTransport(httpNetworkTransport: HTTPNetworkTransport(url: endpointURL),
                                                          webSocketNetworkTransport: websocket)
        
        return ApolloClient(networkTransport: splitNetworkTransport)
    }
    
    private func openRootScreen() {
        let rootController = UINavigationController()
        appContainer.register { CleanWeatherCoordinator(rootController: rootController) }

        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? WeatherCitiesViewController else { return }
        
        rootController.pushViewController(controller, animated: false)
        self.window.rootViewController = rootController
        self.window.makeKeyAndVisible()
    }
}
