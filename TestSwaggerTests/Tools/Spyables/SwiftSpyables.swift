//
//  SwiftSpyables.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger


//  Root sample class

class SwiftRootSpyable: Spyable {

    class var callsSuperclass: Bool {
        get {
            return false
        }
        set {}
    }

    dynamic class func sampleClassMethod(_ input: String) -> Int {
        return NormalMethodReturnValueAtRoot
    }

    dynamic func sampleInstanceMethod(_ input: String) -> Int {
        return NormalMethodReturnValueAtRoot
    }

}


// Overriding subclasses

class SwiftOverrider: SwiftRootSpyable {

    private static var swiftOverriderCallsSuperclass = false
    override class var callsSuperclass: Bool {
        get {
            return swiftOverriderCallsSuperclass
        }
        set {
            swiftOverriderCallsSuperclass = newValue
        }
    }

    override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverrider.callsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel1
        }
    }

    override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverrider.callsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel1
        }
    }

}

class SwiftOverriderOfOverrider: SwiftOverrider {

    private static var swiftOverriderOfOverriderCallsSuperclass = false
    override class var callsSuperclass: Bool {
        get {
            return swiftOverriderOfOverriderCallsSuperclass
        }
        set {
            swiftOverriderOfOverriderCallsSuperclass = newValue
        }
    }

    override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverriderOfOverrider.callsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel2
        }
    }

    override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverriderOfOverrider.callsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel2
        }
    }

}


// Inheriting subclasses

class SwiftInheritor: SwiftRootSpyable {}

class SwiftInheritorOfInheritor: SwiftInheritor {}


//  Hybrid subclasses

class SwiftOverriderOfInheritor: SwiftInheritor {

    private static var swiftOverriderOfInheritorCallsSuperclass = false
    override class var callsSuperclass: Bool {
        get {
            return swiftOverriderOfInheritorCallsSuperclass
        }
        set {
            swiftOverriderOfInheritorCallsSuperclass = newValue
        }
    }

    override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverriderOfInheritor.callsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel2
        }
    }

    override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverriderOfInheritor.callsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return NormalMethodReturnValueOverridenAtLevel2
        }
    }

}

class SwiftInheritorOfOverrider: SwiftOverrider {}
