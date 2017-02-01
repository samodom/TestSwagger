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

    fileprivate enum SampleSpyCoselectors {

        static let directClassSpy = SpyCoselectors(
            ofType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.directSpyClassMethod
        )

        static let directObjectSpy = SpyCoselectors(
            ofType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.directSpyInstanceMethod
        )

        static let indirectClassSpy = SpyCoselectors(
            ofType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.indirectSpyClassMethod
        )

        static let indirectObjectSpy = SpyCoselectors(
            ofType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.indirectSpyInstanceMethod
        )
        
    }

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
        return DirectInvocationSpy(
            on: subject,
            rootClass: SwiftRootSpyable.self,
            selectors: SampleSpyCoselectors.directClassSpy
        )
    }

    class func createDirectInvocationObjectSpy(on subject: SwiftRootSpyable) -> Spy {
        return DirectInvocationSpy(
            on: subject,
            rootClass: SwiftRootSpyable.self,
            selectors: SampleSpyCoselectors.directObjectSpy
        )!
    }

    class func createIndirectInvocationClassSpy(on subject: AnyClass) -> Spy? {
        return IndirectInvocationSpy(
            on: subject,
            rootClass: SwiftRootSpyable.self,
            selectors: SampleSpyCoselectors.indirectClassSpy
        )
    }

    class func createIndirectInvocationObjectSpy(on subject: SwiftRootSpyable) -> Spy? {
        return IndirectInvocationSpy(
            on: subject,
            rootClass: SwiftRootSpyable.self,
            selectors: SampleSpyCoselectors.indirectObjectSpy
        )
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
