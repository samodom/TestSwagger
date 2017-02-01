//
//  SampleDirectInvocationClassSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger
import SampleTypes
import FoundationSwagger


extension SwiftRootSpyable: Spyable {}

fileprivate extension SwiftRootSpyable {

    enum SampleMethodSelectors {
        static let originalClassMethod = #selector(SwiftRootSpyable.sampleClassMethod(_:))
        static let directSpyClassMethod = #selector(SwiftRootSpyable.directSpy_sampleClassMethod(_:))
        static let indirectSpyClassMethod = #selector(SwiftRootSpyable.indirectSpy_sampleClassMethod(_:))

        static let originalInstanceMethod = #selector(SwiftRootSpyable.sampleInstanceMethod(_:))
        static let directSpyInstanceMethod = #selector(SwiftRootSpyable.directSpy_sampleInstanceMethod(_:))
        static let indirectSpyInstanceMethod = #selector(SwiftRootSpyable.indirectSpy_sampleInstanceMethod(_:))
    }

    static var SwiftRootSpyableSelectorForwarding = [
        SampleMethodSelectors.originalClassMethod: true,
        SampleMethodSelectors.originalInstanceMethod: true
    ]

}


// MARK: Spy methods

extension SwiftRootSpyable {

    dynamic class func directSpy_sampleClassMethod(_ input: String) -> Int {
        return forwardsSpyMethodCalls(for: SampleMethodSelectors.originalClassMethod) ?
            directSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func directSpy_sampleInstanceMethod(_ input: String) -> Int {
        return SwiftRootSpyable.forwardsSpyMethodCalls(for: SampleMethodSelectors.originalInstanceMethod) ?
            directSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic class func indirectSpy_sampleClassMethod(_ input: String) -> Int {
        return forwardsSpyMethodCalls(for: SampleMethodSelectors.originalClassMethod) ?
            indirectSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func indirectSpy_sampleInstanceMethod(_ input: String) -> Int {
        return SwiftRootSpyable.forwardsSpyMethodCalls(for: SampleMethodSelectors.originalInstanceMethod) ?
            indirectSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

}


// MARK: Spies

extension SwiftRootSpyable {

    class func createDirectInvocationClassSpy(on subject: AnyClass) -> Spy? {

        guard directClassMethodInvocationSubjectIsValid(subject) else {
            return nil
        }

        let coselectors = SpyCoselectors(
            ofType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.directSpyClassMethod
        )

        return DirectInvocationSpy(on: subject, selectors: coselectors)
    }

    class func createDirectInvocationInstanceSpy(on subject: SwiftRootSpyable) -> Spy {
        let coselectors = SpyCoselectors(
            ofType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.directSpyInstanceMethod
        )

        return DirectInvocationSpy(on: subject, selectors: coselectors)
    }

    class func createIndirectInvocationClassSpy(on subject: AnyClass) -> Spy? {
        guard let target = indirectClassMethodInvocationTarget(
            for: subject,
            rootClass: SwiftRootSpyable.self
            ) else {
            return nil
        }

        let coselectors = SpyCoselectors(
            ofType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.indirectSpyClassMethod
        )

        return IndirectInvocationSpy(on: target, selectors: coselectors)
    }

    class func createIndirectInvocationInstanceSpy(on subject: SwiftRootSpyable) -> Spy? {
        guard let target = indirectInstanceMethodInvocationTarget(
            for: subject,
            rootClass: SwiftRootSpyable.self
            ) else {
                return nil
        }

        let coselectors = SpyCoselectors(
            ofType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.indirectSpyInstanceMethod
        )

        return IndirectInvocationSpy(on: target, selectors: coselectors)
    }

}


// MARK: Spy method forwarding

extension SwiftRootSpyable {

    class func forwardsSpyMethodCalls(for selector: Selector) -> Bool {
        return SwiftRootSpyableSelectorForwarding[selector] ?? false
    }

    class func setSpyMethodForwarding(for selector: Selector, forwards: Bool) {
        SwiftRootSpyableSelectorForwarding[selector] = forwards
    }

    class func setAllSpyMethodForwarding(to forwards: Bool) {
        SwiftRootSpyableSelectorForwarding.keys.forEach { key in
            SwiftRootSpyableSelectorForwarding[key] = forwards
        }
    }

}
