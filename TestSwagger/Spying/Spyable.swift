//
//  Spyable.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

/// A protocol for classes with methods and/or properties upon which one would like to spy.
public protocol Spyable: class, ObjectAssociating {}

public extension Spyable {

    public static func indirectClassMethodInvocationTarget(
        for subject: AnyClass,
        rootClass: AnyClass
        ) -> AnyClass? {

        guard subject != rootClass,
            let target = class_getSuperclass(subject),
            target.isSubclass(of: rootClass)
            else {
                return nil
        }

        return target
    }

    public static func indirectInstanceMethodInvocationTarget(
        for subject: Spyable,
        rootClass: AnyClass
        ) -> AnyClass? {

        guard let subjectClass: AnyClass = object_getClass(subject),
            subjectClass != rootClass,
            let target = class_getSuperclass(subjectClass)
            else {
                return nil
        }

        return target
    }

    public static func directClassMethodInvocationSubjectIsValid(_ subject: AnyClass) -> Bool {
        return subject.isSubclass(of: self)
    }

}
