//
//  Spy.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger


/// Typealias for closures used when spying in-context.
public typealias SpyExecutionContext = NullaryVoidClosure


/// Convenience type used to create method surrogates for spying.
public struct SpyCoselectors {
    let methodType: MethodType
    let original: Selector
    let spy: Selector

    /// Creates a new spy co-selector.
    /// - parameter ofType: The method type of the methods implemented by the selectors.
    /// - parameter original: The selector of the original method defined by the root
    ///                       spyable class that is spied upon.
    /// - parameter spy: The selector of the spy method defined for the purposes of spying
    ///                  on calls to the original method
    public init(
        ofType methodType: MethodType,
        original: Selector,
        spy: Selector
        ) {

        self.methodType = methodType
        self.original = original
        self.spy = spy
    }
}


/// A type of test double that captures *evidence* about method invocations.
public protocol Spy {

    /// Type-level variable indicating the forwarding behavior of spy methods.
//    static var forwardsMethodCalls: Bool { get }

    /// The method surrogate used to swap the real method's implementation with that of the spy.
    var surrogate: MethodSurrogate { get }
}


public extension Spy {

    /// Used to spy on a test subject's method within a context.
    /// - parameter on: Context during which the spy will be active.
    func spy(on context: SpyExecutionContext) {
        surrogate.withAlternateImplementation(context: context)
//        cleanUpEvidence()
    }


    /// Used to activate spying on a test subject's method.
    /// - note: Calls to this method should be balanced by a call to `endSpying`.
    func beginSpying() {
        surrogate.useAlternateImplementation()
    }


    /// Used to deactivate spying on a test subject's method.
    func endSpying() {
        surrogate.useOriginalImplementation()
//        cleanUpEvidence()
    }

//    func cleanUpEvidence() {}

}
