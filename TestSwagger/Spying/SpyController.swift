//
//  SpyController.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/2/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger


/// A static group of values that provide information used in the construction of a spy.
public protocol SpyController {

    /// The original class defining a test subject's spyable method.
    static var rootSpyableClass: AnyClass { get }


    /// The type of spy mechanism being used: direct-invocation or indirect-invocation.
    static var vector: SpyVector { get }


    /// All selector pairs of original and spy methods along with their method types.
    static var coselectors: Set<SpyCoselectors> { get }


    /// A set of evidence reference items used in cleaning up evidence after spying.
    static var evidence: Set<SpyEvidenceReference> { get }


    /// Method-forwarding behavior to be used by spy methods.
    static var forwardsInvocations: Bool { get }

}


public extension SpyController {

    /// Common spy-creation method
    /// - parameter subject: The subject on which one intends to spy.
    /// - returns: A new spy on the subject or nil if the subject is invalid.
    public static func createSpy(on subject: Any) -> Spy? {

        guard let owningClass = spyTarget(for: subject, vector: vector) else {
            return nil
        }

        let surrogates = coselectors.map { coselector in
            MethodSurrogate(
                forClass: owningClass,
                ofType: coselector.methodType,
                originalSelector: coselector.original,
                alternateSelector: coselector.spy
            )
        }

        return Spy(subject: subject, surrogates: surrogates, evidence: evidence)
    }

}


fileprivate extension SpyController {

    static func spyTarget(for subject: Any, vector: SpyVector) -> AnyClass? {
        switch vector {
        case .direct:
            return directInvocationSpyTarget(for: subject, rootClass: rootSpyableClass)

        case .indirect:
            return indirectInvocationSpyTarget(for: subject, rootClass: rootSpyableClass)
        }
    }


    private static func directInvocationSpyTarget(for subject: Any, rootClass: AnyClass) -> AnyClass? {
        if let subjectAsClass = subject as? AnyClass {
            return subjectAsClass.isSubclass(of: rootClass) ? subjectAsClass : nil
        }
        else {
            return object_getClass(subject)
        }
    }

    private static func indirectInvocationSpyTarget(for subject: Any, rootClass: AnyClass) -> AnyClass? {
        if let subjectAsClass = subject as? AnyClass {
            return indirectInvocationClassSpyTarget(for: subjectAsClass, rootClass: rootClass)
        }
        else {
            return indirectInvocationObjectSpyTarget(for: subject, rootClass: rootClass)
        }
    }

    private static func indirectInvocationClassSpyTarget(for subject: AnyClass, rootClass: AnyClass) -> AnyClass? {
        guard subject != rootClass,
            let target = class_getSuperclass(subject),
            target.isSubclass(of: rootClass)
            else {
                return nil
        }

        return target
    }

    private static func indirectInvocationObjectSpyTarget(for subject: Any, rootClass: AnyClass) -> AnyClass? {
        guard let subjectClass: AnyClass = object_getClass(subject),
            subjectClass != rootClass,
            let target = class_getSuperclass(subjectClass)
            else {
                return nil
        }

        return target
    }
    
}
