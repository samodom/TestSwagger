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

extension ObjectiveCRootSpyable: Spyable {}

extension ObjectiveCRootSpyable {

    enum SampleMethodSelectors {
        static let originalClassMethod = #selector(ObjectiveCRootSpyable.sampleClassMethod(_:))
        static let directSpyClassMethod = #selector(ObjectiveCRootSpyable.directSpy_sampleClassMethod(_:))
        static let indirectSpyClassMethod = #selector(ObjectiveCRootSpyable.indirectSpy_sampleClassMethod(_:))

        static let originalInstanceMethod = #selector(ObjectiveCRootSpyable.sampleInstanceMethod(_:))
        static let directSpyInstanceMethod = #selector(ObjectiveCRootSpyable.directSpy_sampleInstanceMethod(_:))
        static let indirectSpyInstanceMethod = #selector(ObjectiveCRootSpyable.indirectSpy_sampleInstanceMethod(_:))
    }

    fileprivate static var ObjectiveCRootSpyableSelectorForwarding = [
        SampleMethodSelectors.originalClassMethod: false,
        SampleMethodSelectors.originalInstanceMethod: false
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

extension ObjectiveCRootSpyable {

    class func createDirectInvocationClassSpy(on subject: AnyClass) -> Spy? {
        return DirectInvocationSpy(
            on: subject,
            rootClass: ObjectiveCRootSpyable.self,
            selectors: SampleSpyCoselectors.directClassSpy
        )
    }

    class func createDirectInvocationObjectSpy(on subject: ObjectiveCRootSpyable) -> Spy {
        return DirectInvocationSpy(
            on: subject,
            rootClass: ObjectiveCRootSpyable.self,
            selectors: SampleSpyCoselectors.directObjectSpy
        )!
    }

    class func createIndirectInvocationClassSpy(on subject: AnyClass) -> Spy? {
        return IndirectInvocationSpy(
            on: subject,
            rootClass: ObjectiveCRootSpyable.self,
            selectors: SampleSpyCoselectors.indirectClassSpy
        )
    }


    class func createIndirectInvocationObjectSpy(on subject: ObjectiveCRootSpyable) -> Spy? {
        return IndirectInvocationSpy(
            on: subject,
            rootClass: ObjectiveCRootSpyable.self,
            selectors: SampleSpyCoselectors.indirectObjectSpy
        )
    }

    class func forwardsSpyMethodCalls(for selector: Selector) -> Bool {
        return ObjectiveCRootSpyableSelectorForwarding[selector] ?? false
    }

    class func setSpyMethodForwarding(for selector: Selector, forwards: Bool) {
        ObjectiveCRootSpyableSelectorForwarding[selector] = forwards
    }

    class func setAllSpyMethodForwarding(to forwards: Bool) {
        ObjectiveCRootSpyableSelectorForwarding.keys.forEach { key in
            ObjectiveCRootSpyableSelectorForwarding[key] = forwards
        }
    }

    dynamic class func directSpy_sampleClassMethod(_ input: String) -> Int {
        return forwardsSpyMethodCalls(for: SampleMethodSelectors.originalClassMethod) ?
            directSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func directSpy_sampleInstanceMethod(_ input: String) -> Int {
        return ObjectiveCRootSpyable.forwardsSpyMethodCalls(for: SampleMethodSelectors.originalInstanceMethod) ?
            directSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic class func indirectSpy_sampleClassMethod(_ input: String) -> Int {
        return forwardsSpyMethodCalls(for: SampleMethodSelectors.originalClassMethod) ?
            indirectSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func indirectSpy_sampleInstanceMethod(_ input: String) -> Int {
        return ObjectiveCRootSpyable.forwardsSpyMethodCalls(for: SampleMethodSelectors.originalInstanceMethod) ?
            indirectSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

}