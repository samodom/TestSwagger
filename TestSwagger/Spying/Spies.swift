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

    public init(
        on subject: Subject,
        selectors: SpyCoselectors
        ) {

        let subjectClass: AnyClass = object_getClass(subject)
        _surrogate = MethodSurrogate(
            forClass: subjectClass,
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

    public init(
        on subject: Subject,
        selectors: SpyCoselectors
        ) {

        let owningClass: AnyClass
        if let subjectAsClass = subject as? AnyClass {
           owningClass = subjectAsClass
        }
        else {
            owningClass = object_getClass(subject)
        }

        _surrogate = MethodSurrogate(
            forClass: owningClass,
            ofType: selectors.methodType,
            originalSelector: selectors.original,
            alternateSelector: selectors.spy
        )
    }
    
}
