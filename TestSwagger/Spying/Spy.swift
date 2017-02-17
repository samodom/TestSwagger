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


/// Type used to specify whether a spy is for testing a direct method call or
/// an indirect (inherited) method call
public enum SpyVector {
    case direct
    case indirect
}


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


/// Testing class provided for spying on particular class to ensure that calls are made
/// to a particular class or instance metnod.
public final class Spy {

    let subject: Any
    fileprivate let surrogate: MethodSurrogate
    let evidence: Set<SpyEvidenceReference>

    init(subject: Any,
         surrogate: MethodSurrogate,
         evidence: Set<SpyEvidenceReference>
        ) {

        self.subject = subject
        self.surrogate = surrogate
        self.evidence = evidence
    }

}


public extension Spy {

    /// Used to spy on a test subject's method within a context.
    /// - parameter context: Context during which the spy will be active.
    public func spy(on context: SpyExecutionContext) {
        surrogate.withAlternateImplementation(context: context)
        cleanUpEvidence()
    }


    /// Used to activate spying on a test subject's method.
    /// - note: Calls to this method should be balanced by a call to `endSpying`.
    public func beginSpying() {
        surrogate.useAlternateImplementation()
    }


    /// Used to deactivate spying on a test subject's method.
    public func endSpying() {
        surrogate.useOriginalImplementation()
        cleanUpEvidence()
    }

}


fileprivate extension Spy {

    func cleanUpEvidence() {
        if let spyableObject = subjectAsSpyableObject {
            evidence.forEach(spyableObject.removeEvidence(with:))
        }
        else if let spyableClass = subjectAsSpyableClass {
            evidence.forEach(spyableClass.removeEvidence(with:))
        }
            // TODO: REMOVE!!!
        else { fatalError() }
    }

    var subjectAsSpyableObject: SpyableObject? {
        return subject as? SpyableObject
    }

    var subjectAsSpyableClass: SpyableClass.Type? {
        return subject as? SpyableClass.Type
    }

}
