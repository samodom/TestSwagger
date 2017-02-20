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
