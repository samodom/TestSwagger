//
//  SampleDirectInvocationClassSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger
import FoundationSwagger


extension SwiftRootSpyable {

    class DirectInvocationClassSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: AnyClass) {
            association = MethodAssociation(
                forClass: subject,
                ofType: .class,
                originalSelector: #selector(SwiftRootSpyable.sampleClassMethod(_:)),
                alternateSelector: #selector(SwiftRootSpyable.directSpy_sampleClassMethod(_:))
            )
        }

    }

    dynamic class func directSpy_sampleClassMethod(_ input: String) -> Int {
        return DirectInvocationClassSpy.forwardsMethodCalls ?
            directSpy_sampleClassMethod(input) : SpyMethodReturnValue
    }

}


extension ObjectiveCRootSpyable {

    class DirectInvocationClassSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: AnyClass) {
            association = MethodAssociation(
                forClass: subject,
                ofType: .class,
                originalSelector: #selector(ObjectiveCRootSpyable.sampleClassMethod(_:)),
                alternateSelector: #selector(ObjectiveCRootSpyable.directSpy_sampleClassMethod(_:))
            )
        }

    }

    dynamic class func directSpy_sampleClassMethod(_ input: String) -> Int {
        return DirectInvocationClassSpy.forwardsMethodCalls ?
            directSpy_sampleClassMethod(input) : SpyMethodReturnValue
    }
    
}
