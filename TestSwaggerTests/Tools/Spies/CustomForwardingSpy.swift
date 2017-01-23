//
//  CustomForwardingSpy.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import TestSwagger

protocol CustomForwardingSpy: Spy {
    static var forwardsMethodCalls: Bool { get set }
}
