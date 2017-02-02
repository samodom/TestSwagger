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


/// Type used to specify whether a spy is for testing a direct method call or an inherited,
/// indirect method call
public enum SpyVector {
    case direct(AnyClass)
    case indirect(AnyClass)
}


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


/// Testing class provided for spying on particular class to ensure that calls are made
/// to a particular class or instance metnod.
public final class Spy {

    fileprivate let surrogate: MethodSurrogate

    /// Creates either a direct- or an indirect-invocation spy using the provided subject and
    /// co-selectors if the subject is valid.
    /// - parameter on: The subject of the spy which is either a spyable class (or one
    ///                 of its subclasses) or an instance of such a class.
    /// - parameter rootClass: The root spyable class defining the method to be spied upon.
    /// - parameter selectors: The pair of selectors used in spying along with their method type.
    /// - parameter vector: The invocation type being tested.
    /// - note: In order to successfully create a spy, the following criteria must be met:
    ///   * (Direct-invocation spying) The subject must be or be an instance of the root
    ///     class (or one of its subclasses) for class-method and instance-method spying,
    ///     respectively.
    ///   * (Indirect-invocation spying) The subject must be or be an instance of a subclass
    ///     of the root class for class-method and instance-method spying, respectively.
    public init?(
        on subject: Any,
        selectors: SpyCoselectors,
        vector: SpyVector
        ) {

        guard let owningClass = Spy.spyTarget(for: subject, vector: vector) else {
            return nil
        }

        surrogate = MethodSurrogate(
            forClass: owningClass,
            ofType: selectors.methodType,
            originalSelector: selectors.original,
            alternateSelector: selectors.spy
        )
    }

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


fileprivate extension Spy {

    static func spyTarget(for subject: Any, vector: SpyVector) -> AnyClass? {
        switch vector {
        case .direct(let rootClass):
            return directInvocationSpyTarget(for: subject, rootClass: rootClass)

        case .indirect(let rootClass):
            return indirectInvocationSpyTarget(for: subject, rootClass: rootClass)
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

