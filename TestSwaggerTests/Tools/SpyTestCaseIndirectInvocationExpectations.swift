//
//  SpyTestCaseIndirectInvocationExpectations.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


extension SpyTestCase {

    func createSwiftIndirectInvocationSpyExpectations() -> [SpyTestOutputExpectation] {

        let createSpyOnSpyableClass: (AnyClass) -> CustomForwardingSpy = { `class` in
            return SwiftRootSpyable.IndirectInvocationClassSpy(on: `class`)!
        }

        return [
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
                executeSampleMethod: {
                    SwiftOverriderOfInheritor.callsSuperclass = true
                    let output = SwiftOverriderOfInheritor.sampleClassMethod("")
                    SwiftOverriderOfInheritor.callsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftOverrider.self),
                executeSampleMethod: {
                    SwiftOverrider.callsSuperclass = true
                    let output = SwiftOverrider.sampleClassMethod("")
                    SwiftOverrider.callsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftInheritorOfOverrider.self),
                executeSampleMethod: { SwiftInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(SwiftOverriderOfOverrider.self),
                executeSampleMethod: {
                    SwiftOverriderOfOverrider.callsSuperclass = true
                    let output = SwiftOverriderOfOverrider.sampleClassMethod("")
                    SwiftOverriderOfOverrider.callsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            )
        ]

    }

    func createObjectiveCIndirectInvocationSpyExpectations() -> [SpyTestOutputExpectation] {

        let createSpyOnSpyableClass: (AnyClass) -> CustomForwardingSpy = { `class` in
            return ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: `class`)!
        }

        return [
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
                executeSampleMethod: {
                    ObjectiveCOverriderOfInheritor.setCallsSuperclass(true)
                    let output = ObjectiveCOverriderOfInheritor.sampleClassMethod("")
                    ObjectiveCOverriderOfInheritor.setCallsSuperclass(false)
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCOverrider.self),
                executeSampleMethod: {
                    ObjectiveCOverrider.setCallsSuperclass(true)
                    let output = ObjectiveCOverrider.sampleClassMethod("")
                    ObjectiveCOverrider.setCallsSuperclass(false)
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueAtRoot
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCInheritorOfOverrider.self),
                executeSampleMethod: { ObjectiveCInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            ),
            SpyTestOutputExpectation(
                spy: createSpyOnSpyableClass(ObjectiveCOverriderOfOverrider.self),
                executeSampleMethod: {
                    ObjectiveCOverriderOfOverrider.setCallsSuperclass(true)
                    print(ObjectiveCOverrider.callsSuperclass())
                    let output = ObjectiveCOverriderOfOverrider.sampleClassMethod("")
                    ObjectiveCOverriderOfOverrider.setCallsSuperclass(false)
                    return output
                },
                output: unforwardedOutputValue ?? NormalMethodReturnValueOverridenAtLevel1
            )
        ]

    }

}
