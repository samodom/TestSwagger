//
//  SampleSpyable.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import TestSwagger

class SampleSpyable: Spyable {

    var sampleMethodReturnValue: Any?

    func sampleMethod(input: Any) -> Any {
        guard let returnValue = sampleMethodReturnValue else {
            fatalError("No return value set")
        }

        return returnValue
    }

    var sampleMethodInputEvidence: Any?

    func spy_sampleMethod(input: Any) -> Any {
        return spy_sampleMethod(input: input)
    }

}
