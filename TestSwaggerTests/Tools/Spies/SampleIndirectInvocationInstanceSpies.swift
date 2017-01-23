//
//  SampleIndirectInvocationInstanceSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger
import FoundationSwagger


extension SwiftRootSpyable {

    class IndirectInvocationInstanceSpy: Spy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: SwiftRootSpyable) {
            let subjectMirror = Mirror(reflecting: subject)
            association = MethodAssociation(
                forClass: subjectMirror.subjectType as! AnyClass,
                ofType: .instance,
                originalSelector: #selector(SwiftRootSpyable.sampleInstanceMethod(_:)),
                alternateSelector: #selector(SwiftRootSpyable.indirectSpy_sampleInstanceMethod(_:))
            )
        }

    }

    @objc func indirectSpy_sampleInstanceMethod(_ input: String) -> Int {
        return IndirectInvocationInstanceSpy.forwardsMethodCalls ?
            indirectSpy_sampleInstanceMethod(input) : DirectInvocationSpyDummyReturnValue
    }

}


extension ObjectiveCRootSpyable {

    class IndirectInvocationInstanceSpy: Spy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init(on subject: ObjectiveCRootSpyable) {
            let subjectMirror = Mirror(reflecting: subject)
            association = MethodAssociation(
                forClass: subjectMirror.subjectType as! AnyClass,
                ofType: .instance,
                originalSelector: #selector(ObjectiveCRootSpyable.sampleInstanceMethod(_:)),
                alternateSelector: #selector(ObjectiveCRootSpyable.indirectSpy_sampleInstanceMethod(_:))
            )
        }

    }

    @objc func indirectSpy_sampleInstanceMethod(_ input: String) -> Int {
        return IndirectInvocationInstanceSpy.forwardsMethodCalls ?
            indirectSpy_sampleInstanceMethod(input) : DirectInvocationSpyDummyReturnValue
    }
    
}
