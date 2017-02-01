//
//  SpyTestCaseIndirectInvocationExpectations.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import TestSwagger


extension SpyTestCase {

    func createSwiftIndirectInvocationClassSpyExpectations() -> [SpyTestOutputExpectation] {
        return [
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftInheritor.self)!,
                executeSampleMethod: { SwiftInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftInheritorOfInheritor.self)!,
                executeSampleMethod: { SwiftInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftOverriderOfInheritor.self)!,
                executeSampleMethod: {
                    SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = true
                    let output = SwiftOverriderOfInheritor.sampleClassMethod("")
                    SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftOverrider.self)!,
                executeSampleMethod: {
                    SwiftOverrider.swiftOverriderCallsSuperclass = true
                    let output = SwiftOverrider.sampleClassMethod("")
                    SwiftOverrider.swiftOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftInheritorOfOverrider.self)!,
                executeSampleMethod: { SwiftInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationClassSpy(on: SwiftOverriderOfOverrider.self)!,
                executeSampleMethod: {
                    SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = true
                    let output = SwiftOverriderOfOverrider.sampleClassMethod("")
                    SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            )
        ]
    }

    func createSwiftIndirectInvocationInstanceSpyExpectations() -> [SpyTestOutputExpectation] {
        let inheritor = SwiftInheritor()
        let inheritorOfInheritor = SwiftInheritorOfInheritor()
        let overriderOfInheritor = SwiftOverriderOfInheritor()
        let overrider = SwiftOverrider()
        let inheritorOfOverrider = SwiftInheritorOfOverrider()
        let overriderOfOverrider = SwiftOverriderOfOverrider()

        return [
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: inheritor)!,
                executeSampleMethod: { inheritor.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: inheritorOfInheritor)!,
                executeSampleMethod: { inheritorOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: overriderOfInheritor)!,
                executeSampleMethod: {
                    SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = true
                    let output = overriderOfInheritor.sampleInstanceMethod("")
                    SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: overrider)!,
                executeSampleMethod: {
                    SwiftOverrider.swiftOverriderCallsSuperclass = true
                    let output = overrider.sampleInstanceMethod("")
                    SwiftOverrider.swiftOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: inheritorOfOverrider)!,
                executeSampleMethod: { inheritorOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: SwiftRootSpyable.createIndirectInvocationInstanceSpy(on: overriderOfOverrider)!,
                executeSampleMethod: {
                    SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = true
                    let output = overriderOfOverrider.sampleInstanceMethod("")
                    SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            )
        ]
    }

    func createObjectiveCIndirectInvocationClassSpyExpectations() -> [SpyTestOutputExpectation] {
        return [
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCInheritor.self)!,
                executeSampleMethod: { ObjectiveCInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCInheritorOfInheritor.self)!,
                executeSampleMethod: { ObjectiveCInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCOverriderOfInheritor.self)!,
                executeSampleMethod: {
                    ObjectiveCOverriderOfInheritorCallsSuperclass = true
                    let output = ObjectiveCOverriderOfInheritor.sampleClassMethod("")
                    ObjectiveCOverriderOfInheritorCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCOverrider.self)!,
                executeSampleMethod: {
                    ObjectiveCOverriderCallsSuperclass = true
                    let output = ObjectiveCOverrider.sampleClassMethod("")
                    ObjectiveCOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCInheritorOfOverrider.self)!,
                executeSampleMethod: { ObjectiveCInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationClassSpy(on: ObjectiveCOverriderOfOverrider.self)!,
                executeSampleMethod: {
                    ObjectiveCOverriderOfOverriderCallsSuperclass = true
                    let output = ObjectiveCOverriderOfOverrider.sampleClassMethod("")
                    ObjectiveCOverriderOfOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            )
        ]
    }

    func createObjectiveCIndirectInvocationInstanceSpyExpectations() -> [SpyTestOutputExpectation] {
        let inheritor = ObjectiveCInheritor()
        let inheritorOfInheritor = ObjectiveCInheritorOfInheritor()
        let overriderOfInheritor = ObjectiveCOverriderOfInheritor()
        let overrider = ObjectiveCOverrider()
        let inheritorOfOverrider = ObjectiveCInheritorOfOverrider()
        let overriderOfOverrider = ObjectiveCOverriderOfOverrider()

        return [
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: inheritor)!,
                executeSampleMethod: { inheritor.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: inheritorOfInheritor)!,
                executeSampleMethod: { inheritorOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: overriderOfInheritor)!,
                executeSampleMethod: {
                    ObjectiveCOverriderOfInheritorCallsSuperclass = true
                    let output = overriderOfInheritor.sampleInstanceMethod("")
                    ObjectiveCOverriderOfInheritorCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: overrider)!,
                executeSampleMethod: {
                    ObjectiveCOverriderCallsSuperclass = true
                    let output = overrider.sampleInstanceMethod("")
                    ObjectiveCOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: inheritorOfOverrider.self)!,
                executeSampleMethod: { inheritorOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: ObjectiveCRootSpyable.createIndirectInvocationInstanceSpy(on: overriderOfOverrider.self)!,
                executeSampleMethod: {
                    ObjectiveCOverriderOfOverriderCallsSuperclass = true
                    let output = overriderOfOverrider.sampleInstanceMethod("")
                    ObjectiveCOverriderOfOverriderCallsSuperclass = false
                    return output
                },
                output: unforwardedOutputValue ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            )
        ]
    }

}
