//
//  SpyCoselectors.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/19/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger

/// Convenience type used to create method surrogates for spying.
public struct SpyCoselectors {

    let methodType: MethodType
    let original: Selector
    let spy: Selector


    /// Creates a new spy co-selector.
    /// - parameter methodType: The method type of the methods implemented by the selectors.
    /// - parameter original: The selector of the original method defined by the root
    ///                       spyable class that is spied upon.
    /// - parameter spy: The selector of the spy method defined for the purposes of spying
    ///                  on calls to the original method
    public init(methodType: MethodType,
                original: Selector,
                spy: Selector) {

        self.methodType = methodType
        self.original = original
        self.spy = spy
    }
}


extension SpyCoselectors: Equatable {}

public func ==(lhs: SpyCoselectors, rhs: SpyCoselectors) -> Bool {
    return lhs.methodType == rhs.methodType &&
        lhs.original == rhs.original &&
        lhs.spy == rhs.spy
}


extension SpyCoselectors: Hashable {

    public var hashValue: Int {
        return original.hashValue + spy.hashValue
    }

}
