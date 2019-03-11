//
//  AppDelegate.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 2/18/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import UIKit
import CoreData
import DITranquillity

let container = DIContainer()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow(frame: UIScreen.main.bounds)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.initDI()
        self.showFirstScreen()
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Clean_Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func showFirstScreen() {
        self.window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        self.window.makeKeyAndVisible()
    }
    
    private func initDI() {
        container.register { API(baseUrl: "http://localhost:8080") }.as(API.self)
        container.register(APICitiesRepository.init).as(CitiesRepository.self)
        container.register(GetCitiesListUseCase.init).as(GetCitiesListUseCase.self)
        container.register(CitiesListViewModelImpl.init).as(CitiesListViewModel.self)
    }
}
