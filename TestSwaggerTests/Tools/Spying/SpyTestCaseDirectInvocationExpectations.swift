//
//  SpyControllerTestCaseDirectInvocationExpectations.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import TestSwagger


extension SpyControllerTestCase {

    func createSwiftDirectInvocationClassSpyExpectations() -> [SpyTestOutputExpectation] {
        return [
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftRootSpyable.self)!,
                executeSampleMethod: { SwiftRootSpyable.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftInheritor.self)!,
                executeSampleMethod: { SwiftInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftInheritorOfInheritor.self)!,
                executeSampleMethod: { SwiftInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftOverriderOfInheritor.self)!,
                executeSampleMethod: { SwiftOverriderOfInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftOverrider.self)!,
                executeSampleMethod: { SwiftOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftInheritorOfOverrider.self)!,
                executeSampleMethod: { SwiftInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: SwiftOverriderOfOverrider.self)!,
                executeSampleMethod: { SwiftOverriderOfOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            )
        ]
    }

    func createSwiftDirectInvocationObjectSpyExpectations() -> [SpyTestOutputExpectation] {
        let root = SwiftRootSpyable()
        let inheritor = SwiftInheritor()
        let inheritorOfInheritor = SwiftInheritorOfInheritor()
        let overriderOfInheritor = SwiftOverriderOfInheritor()
        let overrider = SwiftOverrider()
        let inheritorOfOverrider = SwiftInheritorOfOverrider()
        let overriderOfOverrider = SwiftOverriderOfOverrider()

        return [
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: root)!,
                executeSampleMethod: { root.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritor)!,
                executeSampleMethod: { inheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritorOfInheritor)!,
                executeSampleMethod: { inheritorOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overriderOfInheritor)!,
                executeSampleMethod: { overriderOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overrider)!,
                executeSampleMethod: { overrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritorOfOverrider)!,
                executeSampleMethod: { inheritorOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overriderOfOverrider)!,
                executeSampleMethod: { overriderOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            )
        ]
    }

    func createObjectiveCDirectInvocationClassSpyExpectations() -> [SpyTestOutputExpectation] {
        return [
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCRootSpyable.self)!,
                executeSampleMethod: { ObjectiveCRootSpyable.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCInheritor.self)!,
                executeSampleMethod: { ObjectiveCInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCInheritorOfInheritor.self)!,
                executeSampleMethod: { ObjectiveCInheritorOfInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCOverriderOfInheritor.self)!,
                executeSampleMethod: { ObjectiveCOverriderOfInheritor.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCOverrider.self)!,
                executeSampleMethod: { ObjectiveCOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCInheritorOfOverrider.self)!,
                executeSampleMethod: { ObjectiveCInheritorOfOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: ObjectiveCOverriderOfOverrider.self)!,
                executeSampleMethod: { ObjectiveCOverriderOfOverrider.sampleClassMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            )
        ]
    }

    func createObjectiveCDirectInvocationObjectSpyExpectations() -> [SpyTestOutputExpectation] {
        let root = ObjectiveCRootSpyable()
        let inheritor = ObjectiveCInheritor()
        let inheritorOfInheritor = ObjectiveCInheritorOfInheritor()
        let overriderOfInheritor = ObjectiveCOverriderOfInheritor()
        let overrider = ObjectiveCOverrider()
        let inheritorOfOverrider = ObjectiveCInheritorOfOverrider()
        let overriderOfOverrider = ObjectiveCOverriderOfOverrider()

        return [
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: root)!,
                executeSampleMethod: { root.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritor)!,
                executeSampleMethod: { inheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritorOfInheritor)!,
                executeSampleMethod: { inheritorOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.definedAtRoot.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overriderOfInheritor)!,
                executeSampleMethod: { overriderOfInheritor.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overrider)!,
                executeSampleMethod: { overrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: inheritorOfOverrider)!,
                executeSampleMethod: { inheritorOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
            ),
            SpyTestOutputExpectation(
                spy: controller.createSpy(on: overriderOfOverrider)!,
                executeSampleMethod: { overriderOfOverrider.sampleInstanceMethod("") },
                output: unforwardedOutput ?? WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
            )
        ]
    }

}
