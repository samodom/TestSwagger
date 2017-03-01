//
//  SpyTestVariant.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/14/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger
import SampleTypes
import TestSwagger


enum ProgrammingLanguage {
    case swift
    case objectiveC
}


struct SpyTestVariant {

    let inContext: Bool
    let forwardsInvocations: Bool
    let language: ProgrammingLanguage
    let vector: SpyVector
    let methodType: MethodType

}

extension SpyTestVariant {

    static var allVariants: [SpyTestVariant] {
        let variants = [true, false].flatMap { inContext in
            return [true, false].flatMap { forwardsInvocations in
                [ProgrammingLanguage.swift, .objectiveC].flatMap { language in
                    [SpyVector.direct, .indirect].flatMap { vector in
                        [MethodType.instance, .`class`].map { methodType in
                            SpyTestVariant(
                                inContext: inContext,
                                forwardsInvocations: forwardsInvocations,
                                language: language,
                                vector: vector,
                                methodType: methodType
                            )
                        }
                    }
                }
            }
        }

        assert(variants.count == 32)
        return variants
    }

    var controller: SpyController.Type {
        switch (language, vector, methodType) {
        case (.swift, .direct, .class):
            return SwiftRootSpyable.DirectClassSpyController.self

        case (.swift, .direct, .instance):
            return SwiftRootSpyable.DirectObjectSpyController.self

        case (.swift, .indirect, .class):
            return SwiftRootSpyable.IndirectClassSpyController.self

        case (.swift, .indirect, .instance):
            return SwiftRootSpyable.IndirectObjectSpyController.self

        case (.objectiveC, .direct, .class):
            return ObjectiveCRootSpyable.DirectClassSpyController.self

        case (.objectiveC, .direct, .instance):
            return ObjectiveCRootSpyable.DirectObjectSpyController.self

        case (.objectiveC, .indirect, .class):
            return ObjectiveCRootSpyable.IndirectClassSpyController.self

        case (.objectiveC, .indirect, .instance):
            return ObjectiveCRootSpyable.IndirectObjectSpyController.self
        }
    }

    var unforwardedOutputValue: Int? {
        return forwardsInvocations ? nil : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

}


extension SpyTestVariant: CustomStringConvertible {

    public var description: String {
        return "\tlanguage = \(language)\n"
            .appending("\tvector = \(vector)\n")
            .appending("\tmethod type = \(methodType)\n")
            .appending("\tforwarding? \(forwardsInvocations)\n")
            .appending("\tin context? \(inContext)")
    }
    
}
