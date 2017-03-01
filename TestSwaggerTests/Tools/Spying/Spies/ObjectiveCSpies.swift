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

extension ObjectiveCRootSpyable: SampleObjectSpyable, SampleClassSpyable {}


public extension ObjectiveCRootSpyable { // MARK: Spy controllers

    public enum DirectClassSpyController: SpyController {
        public static let rootSpyableClass: AnyClass = ObjectiveCRootSpyable.self
        public static let vector = SpyVector.direct
        public static let coselectors: Set<SpyCoselectors> = [SampleSpyCoselectors.directClassSpy]
        public static let evidence: Set<SpyEvidenceReference> = SampleReferences
        public static var forwardsInvocations = false
    }

    public enum DirectObjectSpyController: SpyController {
        public static let rootSpyableClass: AnyClass = ObjectiveCRootSpyable.self
        public static let vector = SpyVector.direct
        public static let coselectors: Set<SpyCoselectors> = [SampleSpyCoselectors.directObjectSpy]
        public static let evidence: Set<SpyEvidenceReference> = SampleReferences
        public static var forwardsInvocations = false
    }

    public enum IndirectClassSpyController: SpyController {
        public static let rootSpyableClass: AnyClass = ObjectiveCRootSpyable.self
        public static let vector = SpyVector.indirect
        public static let coselectors: Set<SpyCoselectors> = [SampleSpyCoselectors.indirectClassSpy]
        public static let evidence: Set<SpyEvidenceReference> = SampleReferences
        public static var forwardsInvocations = false
    }

    public enum IndirectObjectSpyController: SpyController {
        public static let rootSpyableClass: AnyClass = ObjectiveCRootSpyable.self
        public static let vector = SpyVector.indirect
        public static let coselectors: Set<SpyCoselectors> = [SampleSpyCoselectors.indirectObjectSpy]
        public static let evidence: Set<SpyEvidenceReference> = SampleReferences
        public static var forwardsInvocations = false
    }

}


extension ObjectiveCRootSpyable { // MARK: Selectors

    enum SampleMethodSelectors {
        static let originalClassMethod = #selector(ObjectiveCRootSpyable.sampleClassMethod(_:))
        static let directSpyClassMethod = #selector(ObjectiveCRootSpyable.directSpy_sampleClassMethod(_:))
        static let indirectSpyClassMethod = #selector(ObjectiveCRootSpyable.indirectSpy_sampleClassMethod(_:))

        static let originalInstanceMethod = #selector(ObjectiveCRootSpyable.sampleInstanceMethod(_:))
        static let directSpyInstanceMethod = #selector(ObjectiveCRootSpyable.directSpy_sampleInstanceMethod(_:))
        static let indirectSpyInstanceMethod = #selector(ObjectiveCRootSpyable.indirectSpy_sampleInstanceMethod(_:))
    }

    fileprivate enum SampleSpyCoselectors {

        static let directClassSpy = SpyCoselectors(
            methodType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.directSpyClassMethod
        )

        static let directObjectSpy = SpyCoselectors(
            methodType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.directSpyInstanceMethod
        )

        static let indirectClassSpy = SpyCoselectors(
            methodType: .class,
            original: SampleMethodSelectors.originalClassMethod,
            spy: SampleMethodSelectors.indirectSpyClassMethod
        )

        static let indirectObjectSpy = SpyCoselectors(
            methodType: .instance,
            original: SampleMethodSelectors.originalInstanceMethod,
            spy: SampleMethodSelectors.indirectSpyInstanceMethod
        )
        
    }

}


extension ObjectiveCRootSpyable { // MARK: Spy methods

    dynamic class func directSpy_sampleClassMethod(_ input: String) -> Int {
        sampleClassMethodCalledAssociated = true
        sampleClassMethodCalledSerialized = true

        return DirectClassSpyController.forwardsInvocations ?
            directSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func directSpy_sampleInstanceMethod(_ input: String) -> Int {
        sampleInstanceMethodCalledAssociated = true
        sampleInstanceMethodCalledSerialized = true

        return DirectObjectSpyController.forwardsInvocations ?
            directSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic class func indirectSpy_sampleClassMethod(_ input: String) -> Int {
        sampleClassMethodCalledAssociated = true
        sampleClassMethodCalledSerialized = true

        return IndirectClassSpyController.forwardsInvocations ?
            indirectSpy_sampleClassMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    dynamic func indirectSpy_sampleInstanceMethod(_ input: String) -> Int {
        sampleInstanceMethodCalledAssociated = true
        sampleInstanceMethodCalledSerialized = true

        return IndirectObjectSpyController.forwardsInvocations ?
            indirectSpy_sampleInstanceMethod(input) : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

}
