//
//  SwiftSpyables.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger


//  Root sample class

class RootSwiftSpyable:Spyable {

    class func sampleMethod(_ input: String) -> Int {
        return RootMethodReturnValue
    }

    func sampleMethod(_ input: String) -> Int {
        return RootMethodReturnValue
    }

}


// Overriding subclasses

class FirstOverridingSwiftSpyable : RootSwiftSpyable {

    override class func sampleMethod(_ input: String) -> Int {
        return FirstOverridingMethodReturnValue
    }

    override func sampleMethod(_ input: String) -> Int {
        return FirstOverridingMethodReturnValue
    }

}

class SecondOverridingSwiftSpyable : FirstOverridingSwiftSpyable {

    override class func sampleMethod(_ input: String) -> Int {
        return SecondOverridingMethodReturnValue
    }

    override func sampleMethod(_ input: String) -> Int {
        return SecondOverridingMethodReturnValue
    }

}


// Inheriting subclasses

class FirstInheritingSwiftSpyable : RootSwiftSpyable {}

class SecondInheritingSwiftSpyable : FirstInheritingSwiftSpyable {}


//  Hybrid subclasses

class InheritingSwiftSpyableOverrider : FirstInheritingSwiftSpyable {

    override class func sampleMethod(_ input: String) -> Int {
        return SecondOverridingMethodReturnValue
    }

    override func sampleMethod(_ input: String) -> Int {
        return SecondOverridingMethodReturnValue
    }

}

class OverridingSwiftSpyableInheritor : FirstOverridingSwiftSpyable {}
