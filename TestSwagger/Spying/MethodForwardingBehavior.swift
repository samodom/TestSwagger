//
//  MethodForwardingBehavior.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/17/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

/// Type allowing spy controllers to specify whether its spy method
/// forwarding calls to the original method.
public enum MethodForwardingBehavior {

    /// Represents a controller with a spy method that is always forwarded to the original method.
    case always


    /// Represents a controller with a spy method that is never forwarded to the original method.
    case never


    /// Represents a controller with a spy method that may or may not be forwarded
    /// to the original method based on the provided flag.
    case custom(Bool)


    /// Convenience property to determine the intent of the forwarding behavior.
    public var forwards: Bool {
        switch self {
        case .always, .custom(true):
            return true

        case .never, .custom(false):
            return false
        }
    }

}
