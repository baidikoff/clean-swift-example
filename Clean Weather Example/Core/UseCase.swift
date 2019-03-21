//
//  UseCase.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import RxSwift

protocol SyncUseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(input: Input) -> Output
}

protocol SyncDataUseCase {
    associatedtype Output
    
    func execute() -> Output
}

protocol AsyncUseCase {
    associatedtype Input
    associatedtype Output
    
    func execute(input: Input) -> Observable<Output>
}

protocol AsyncDataUseCase {
    associatedtype Output
    
    func execute() -> Observable<Output>
}

protocol ActionUseCase {
    associatedtype Input
    
    func execute(input: Input)
}
