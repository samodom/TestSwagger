//
//  Spies.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/31/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger


public final class DirectInvocationSpy<Subject>: Spy {

    private let _surrogate: MethodSurrogate

    public var surrogate: MethodSurrogate {
        return _surrogate
    }

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


public final class IndirectInvocationSpy<Subject>: Spy {

    private let _surrogate: MethodSurrogate

    public var surrogate: MethodSurrogate {
        return _surrogate
    }

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
