//
//  SampleDirectInvocationInstanceSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger
import FoundationSwagger


extension SwiftRootSpyable {

    class DirectInvocationInstanceSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: SwiftRootSpyable) {
            let subjectMirror = Mirror(reflecting: subject)
            association = MethodAssociation(
                forClass: subjectMirror.subjectType as! AnyClass,
                ofType: .instance,
                originalSelector: #selector(SwiftRootSpyable.sampleInstanceMethod(_:)),
                alternateSelector: #selector(SwiftRootSpyable.directSpy_sampleInstanceMethod(_:))
            )
        }

    }

    @objc func directSpy_sampleInstanceMethod(_ input: String) -> Int {
        return DirectInvocationInstanceSpy.forwardsMethodCalls ?
            directSpy_sampleInstanceMethod(input) : SpyMethodReturnValue
    }

}


extension ObjectiveCRootSpyable {

    class DirectInvocationInstanceSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: ObjectiveCRootSpyable) {
            let subjectMirror = Mirror(reflecting: subject)
            association = MethodAssociation(
                forClass: subjectMirror.subjectType as! AnyClass,
                ofType: .instance,
                originalSelector: #selector(ObjectiveCRootSpyable.sampleInstanceMethod(_:)),
                alternateSelector: #selector(ObjectiveCRootSpyable.directSpy_sampleInstanceMethod(_:))
            )
        }

    }

    @objc func directSpy_sampleInstanceMethod(_ input: String) -> Int {
        return DirectInvocationInstanceSpy.forwardsMethodCalls ?
            directSpy_sampleInstanceMethod(input) : SpyMethodReturnValue
    }
    
}
