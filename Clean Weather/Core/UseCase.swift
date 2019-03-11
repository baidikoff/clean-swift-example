//
//  UseCase.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 2/18/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// Generic use case protocol
protocol UseCase {
    
    /// Input data type
    associatedtype Input
    
    /// Output data type
    associatedtype Output
    
    /// Action func
    func action(input: Input) -> Output
}

/// Data use case
/// Accepts no input parameters
protocol DataUseCase: UseCase where Input == Void {
    
    /// Action func
    func action() -> Output
}

/// Action use case
/// Does not produce any output
protocol ActionUseCase: UseCase where Output == Void {
}

/// Failable async use case
/// Produces future with possible errors
protocol AsyncUseCase {
    
    /// Input data type
    associatedtype Input
    
    /// Output result type
    associatedtype Output
    
    /// Action func
    func action(input: Input) -> Single<Output>
}

/// Data async use case
/// Produces single
protocol DataAsyncUseCase {
    
    /// Output result type
    associatedtype Output
    
    /// Action func
    func action() -> Single<Output>
}

/// Action async use case
/// Performs action without result
protocol ActionAsyncUseCase {
    
    /// Input data type
    associatedtype Input
    
    /// Action func
    func action(input: Input)
}

