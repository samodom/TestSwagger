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
    fileprivate let surrogates: [MethodSurrogate]
    let evidence: Set<SpyEvidenceReference>

    init(subject: Any,
         surrogates: [MethodSurrogate],
         evidence: Set<SpyEvidenceReference>
        ) {

        self.subject = subject
        self.surrogates = surrogates
        self.evidence = evidence
    }

}


public extension Spy {

    /// Used to spy on a test subject's method within a context.
    /// - parameter context: Context during which the spy will be active.
    public func spy(on context: SpyExecutionContext) {
        beginSpying()
        context()
        endSpying()
        cleanUpEvidence()
    }


    /// Used to activate spying on a test subject's method.
    /// - note: Calls to this method should be balanced by a call to `endSpying`.
    public func beginSpying() {
        surrogates.forEach { $0.useAlternateImplementation() }
    }


    /// Used to deactivate spying on a test subject's method.
    public func endSpying() {
        surrogates.forEach { $0.useOriginalImplementation() }
        cleanUpEvidence()
    }

}


fileprivate extension Spy {

    func cleanUpEvidence() {
        if let spyableObject = subjectAsObjectSpyable {
            evidence.forEach(spyableObject.removeEvidence(with:))
        }
        else if let spyableClass = subjectAsClassSpyable {
            evidence.forEach(spyableClass.removeEvidence(with:))
        }
    }

    var subjectAsObjectSpyable: ObjectSpyable? {
        return subject as? ObjectSpyable
    }

    var subjectAsClassSpyable: ClassSpyable.Type? {
        return subject as? ClassSpyable.Type
    }

}
