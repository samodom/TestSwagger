//
//  SampleIndirectInvocationClassSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger
import FoundationSwagger
import Swift

extension SwiftRootSpyable {

    class IndirectInvocationClassSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init?(on subject: AnyClass) {
            guard let parent = class_getSuperclass(subject) else {
                return nil
            }

            guard let cName = class_getName(parent) else {
                    return nil
            }

            guard String(cString: cName) != "SwiftObject" else {
                return nil
            }
            
            association = MethodAssociation(
                forClass: parent,
                ofType: .class,
                originalSelector: #selector(SwiftRootSpyable.sampleClassMethod(_:)),
                alternateSelector: #selector(SwiftRootSpyable.indirectSpy_sampleClassMethod(_:))
            )
        }

    }

    dynamic class func indirectSpy_sampleClassMethod(_ input: String) -> Int {
        return IndirectInvocationClassSpy.forwardsMethodCalls ?
            indirectSpy_sampleClassMethod(input) : SpyMethodReturnValue
    }

}


extension ObjectiveCRootSpyable {

    class IndirectInvocationClassSpy: CustomForwardingSpy {

        static var forwardsMethodCalls = false
        let association: MethodAssociation

        init?(on subject: AnyClass) {
            guard subject != NSObject.self,
                subject != ObjectiveCRootSpyable.self,
                let parent = class_getSuperclass(subject),
                isClass(subject, subclassOf: ObjectiveCRootSpyable.self)
                else {
                    return nil
            }

//            guard let parent = class_getSuperclass(subject) else {
//                    return nil
//            }
//
//            guard let cName = class_getName(parent) else {
//                return nil
//            }
//
//            guard String(cString: cName) != "NSObject" else {
//                return nil
//            }

            association = MethodAssociation(
                forClass: parent,
                ofType: .class,
                originalSelector: #selector(ObjectiveCRootSpyable.sampleClassMethod(_:)),
                alternateSelector: #selector(ObjectiveCRootSpyable.indirectSpy_sampleClassMethod(_:))
            )
        }

    }

    dynamic class func indirectSpy_sampleClassMethod(_ input: String) -> Int {
        return IndirectInvocationClassSpy.forwardsMethodCalls ?
            indirectSpy_sampleClassMethod(input) : SpyMethodReturnValue
    }
    
}
