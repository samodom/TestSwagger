//
//  Spies.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/31/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger


/// Spy class provided for spying on particular class to ensure that calls are made
/// to a particular class or instance metnod.
public final class DirectInvocationSpy<Subject>: Spy {

    private let _surrogate: MethodSurrogate

    public var surrogate: MethodSurrogate {
        return _surrogate
    }

    /// Creates a direct-invocation spy using the provided subject and co-selectors
    /// if the subject is valid.
    /// - parameter on: The subject of the spy which is either a spyable class (or one
    ///                 of its subclasses) or an instance of such a class.
    /// - parameter rootClass: The root spyable class defining the method to be spied upon.
    /// - parameter selectors: The pair of selectors used in spying along with their method type.
    /// - note: In order to successfully create a direct invocation spy, the subject must be or
    ///         be an instance of the root class (or one of its subclasses) for class-method and 
    ///         instance-method spying, respectively.
    public init?(
        on subject: Subject,
        rootClass: AnyClass,
        selectors: SpyCoselectors
        ) {

        guard let owningClass = DirectInvocationSpy.directInvocationSpyTarget(
            for: subject,
            rootClass: rootClass
            ) else {
                return nil
        }
        
        _surrogate = MethodSurrogate(
            forClass: owningClass,
            ofType: selectors.methodType,
            originalSelector: selectors.original,
            alternateSelector: selectors.spy
        )
    }

}


/// Spy class provided for spying on particular subclass to ensure that calls are made
/// to its superclass's implementation of a particular class or instance metnod.
public final class IndirectInvocationSpy<Subject>: Spy {

    private let _surrogate: MethodSurrogate

    public var surrogate: MethodSurrogate {
        return _surrogate
    }

    /// Creates an indirect-invocation spy using the provided subject and co-selectors
    /// if the subject is valid.
    /// - parameter on: The subject of the spy which is either a spyable class (or one
    ///                 of its subclasses) or an instance of such a class.
    /// - parameter rootClass: The root spyable class defining the method to be spied upon.
    /// - parameter selectors: The pair of selectors used in spying along with their method type.
    /// - note: In order to successfully create an indirect invocation spy, the subject must be
    ///         or be an instance of a subclass of the root class for class-method and instance-
    ///         method spying, respectively.
    public init?(
        on subject: Subject,
        rootClass: AnyClass,
        selectors: SpyCoselectors
        ) {

        guard let owningClass = IndirectInvocationSpy.indirectInvocationSpyTarget(
            for: subject,
            rootClass: rootClass
            ) else {
                return nil
        }

        _surrogate = MethodSurrogate(
            forClass: owningClass,
            ofType: selectors.methodType,
            originalSelector: selectors.original,
            alternateSelector: selectors.spy
        )
    }
    
}


fileprivate extension Spy {

    static func directInvocationSpyTarget(for subject: Any, rootClass: AnyClass) -> AnyClass? {
        if let subjectAsClass = subject as? AnyClass {
            return directInvocationClassSpyTarget(for: subjectAsClass, rootClass: rootClass)
        }
        else {
            return object_getClass(subject)
        }
    }

    private static func directInvocationClassSpyTarget(for subject: AnyClass, rootClass: AnyClass) -> AnyClass? {
        return subject.isSubclass(of: rootClass) ? subject : nil
    }


    static func indirectInvocationSpyTarget(for subject: Any, rootClass: AnyClass) -> AnyClass? {
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
