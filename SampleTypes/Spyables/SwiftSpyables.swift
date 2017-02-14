//
//  SwiftSpyables.swift
//  SampleTypes
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


//  Well-known return values

@objc public enum WellKnownMethodReturnValues: Int {
    case definedAtRoot = 14
    case overriddenAtLevel1 = 42
    case overriddenAtLevel2 = 99

    case commonSpyValue = -18
}


//  Root sample class

public class SwiftRootSpyable {

    public dynamic class func sampleClassMethod(_ input: String) -> Int {
        return WellKnownMethodReturnValues.definedAtRoot.rawValue
    }

    public dynamic func sampleInstanceMethod(_ input: String) -> Int {
        return WellKnownMethodReturnValues.definedAtRoot.rawValue
    }

    public init() {}

}


// Inheriting subclasses

public class SwiftInheritor: SwiftRootSpyable {}

public class SwiftInheritorOfInheritor: SwiftInheritor {}


// Overriding subclasses

public class SwiftOverrider: SwiftRootSpyable {

    public static var swiftOverriderCallsSuperclass = false

    public override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverrider.swiftOverriderCallsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
        }
    }

    public override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverrider.swiftOverriderCallsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel1.rawValue
        }
    }

}

public class SwiftOverriderOfOverrider: SwiftOverrider {

    public static var swiftOverriderOfOverriderCallsSuperclass = false

    public override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
        }
    }

    public override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
        }
    }

}


//  Hybrid subclasses

public class SwiftOverriderOfInheritor: SwiftInheritor {

    public static var swiftOverriderOfInheritorCallsSuperclass = false

    public override class func sampleClassMethod(_ input: String) -> Int {
        if SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass {
            return super.sampleClassMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
        }
    }

    public override func sampleInstanceMethod(_ input: String) -> Int {
        if SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass {
            return super.sampleInstanceMethod(input)
        }
        else {
            return WellKnownMethodReturnValues.overriddenAtLevel2.rawValue
        }
    }

}

public class SwiftInheritorOfOverrider: SwiftOverrider {}
