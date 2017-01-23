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


/// A type of test double that captures *evidence* about method invocations.
public protocol Spy {

    /// Root class defining method on which to spy.
//    associatedtype RootSpyable: Spyable


    /// Type-level variable indicating the forwarding behavior of spy methods.
    static var forwardsMethodCalls: Bool { get }


    /// Class defining the spy and original method.
//    var rootClass: Subject { get }


    /// Selector of method being spied upon.
    static var originalSelector: Selector { get }


    /// Selector of spy method.
    static var spySelector: Selector { get }


    /// The method association used to swap the real method's implementation with that of the spy.
    var association: MethodAssociation { get }

}


//public extension Spy {
//
//    static func DirectInvocationSpy(subject: AnyClass) -> Spy {
//
//    }
//
//}


public extension Spy {

    /// Used to spy on a test subject's method within a context.
    /// - parameter on: Context during which the spy will be active.
    func spy(on context: SpyExecutionContext) {
        association.withAlternateImplementation(context: context)
//        cleanUpEvidence()
    }


    /// Used to activate spying on a test subject's method.
    /// - note: Calls to this method should be balanced by a call to `endSpying`.
    func beginSpying() {
        association.useAlternateImplementation()
    }


    /// Used to deactivate spying on a test subject's method.
        func endSpying() {
        association.useOriginalImplementation()
//        cleanUpEvidence()
    }

//    func cleanUpEvidence() {}

}


/// Type of spy for ensuring a method has been invoked on a particular object instance
public class DirectInvocationSpy: Spy {

    /// Type-level variable indicating the forwarding behavior of spy methods.
    public class var forwardsMethodCalls: Bool {
        return false
    }

    public let association: MethodAssociation

    public class var originalSelector: Selector {
        fatalError("Spy classes must provide their own originalSelector values")
    }

    public class var spySelector: Selector {
        fatalError("Spy classes must provide their own spySelector values")
    }

    public class var rootClass: AnyClass {
        fatalError("Spy classes must provide their own rootClass values")
    }

    public init?(subject: Spyable) {

        let rootClass = object_getClass(self)
        guard subject is rootClass else {

        }

        guard let subjectClass = object_getClass(subject),
            !isClassRootType(subjectClass),
            isClass(subjectClass, subclassOf: rootClass)
            else {
                return nil
        }

        association = MethodAssociation(
            forClass: subjectClass,
            ofType: .class,
            originalSelector: originalSelector,
            alternateSelector: spySelector
        )
    }

}


/// Type of spy for ensuring a class calls its superclass's implementation of an inherited method
public protocol IndirectInvocationSpy {
    associatedtype Subject
    init?(subject: AnyClass)
}




private func isClassRootType(_ `class`: AnyClass) -> Bool {
    return !isClassNSObject(`class`) && !isClassSwiftRoot(`class`)
}

private func isClassNSObject(_ `class`: AnyClass) -> Bool {
    return `class` == NSObject.self
}

private func isClassSwiftRoot(_ `class`: AnyClass) -> Bool {
    return String(cString: class_getName(`class`)) == "SwiftObject"
}

private func isClass(_ `class`: AnyClass, subclassOf parent: AnyClass) -> Bool {
    guard `class` != parent else {
        return false
    }

    guard let superclass = class_getSuperclass(`class`) else {
        return false
    }

    return superclass == parent || isClass(superclass, subclassOf: parent)
}
