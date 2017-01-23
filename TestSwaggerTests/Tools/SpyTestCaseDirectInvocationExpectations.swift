//
//  SpyTestCaseDirectInvocationExpectations.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


extension SpyTestCase {

    func createSwiftDirectInvocationSpyExpectations() -> [SpyTestOutputExpectation] {

        let createSpyOnSpyableClass: (AnyClass) -> CustomForwardingSpy = { `class` in
            return SwiftRootSpyable.DirectInvocationClassSpy(on: `class`)
        }

//        let createSpyOnSpyableObject: (Spyable) -> CustomForwardingSpy = { spyable in
//            return SwiftRootSpyable.DirectInvocationInstanceSpy(on: spyable)
//        }

        return [
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftRootSpyable.self),
                executeSampleMethod: { SwiftRootSpyable.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftInheritor.self),
                executeSampleMethod: { SwiftInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftInheritorOfInheritor.self),
                executeSampleMethod: { SwiftInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftOverriderOfInheritor.self),
                executeSampleMethod: { SwiftOverriderOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel2
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftOverrider.self),
                executeSampleMethod: { SwiftOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftInheritorOfOverrider.self),
                executeSampleMethod: { SwiftInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftOverriderOfOverrider.self),
                executeSampleMethod: { SwiftOverriderOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel2
            )
        ]

    }

    func createObjectiveCDirectInvocationSpyExpectations() -> [SpyTestOutputExpectation] {

        let createSpyOnSpyableClass: (AnyClass) -> CustomForwardingSpy = { `class` in
            return ObjectiveCRootSpyable.DirectInvocationClassSpy(on: `class`)
        }

        return [
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCRootSpyable.self),
                executeSampleMethod: { ObjectiveCRootSpyable.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCInheritor.self),
                executeSampleMethod: { ObjectiveCInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCInheritorOfInheritor.self),
                executeSampleMethod: { ObjectiveCInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCOverriderOfInheritor.self),
                executeSampleMethod: { ObjectiveCOverriderOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel2
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCOverrider.self),
                executeSampleMethod: { ObjectiveCOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCInheritorOfOverrider.self),
                executeSampleMethod: { ObjectiveCInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCOverriderOfOverrider.self),
                executeSampleMethod: { ObjectiveCOverriderOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel2
            )
        ]

    }

}
