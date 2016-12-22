//
//  ObjectiveCSpyables.h
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

@import Foundation;


//  Well-known return values

FOUNDATION_EXPORT NSInteger const RootMethodReturnValue;
FOUNDATION_EXPORT NSInteger const FirstOverridingMethodReturnValue;
FOUNDATION_EXPORT NSInteger const SecondOverridingMethodReturnValue;


//  Root sample class

@interface RootObjectiveCSpyable : NSObject

+ (NSInteger)sampleMethod:(NSString *)input;
- (NSInteger)sampleMethod:(NSString *)input;

@end


// Overriding subclasses

@interface FirstOverridingObjectiveCSpyable: RootObjectiveCSpyable
@end

@interface SecondOverridingObjectiveCSpyable: FirstOverridingObjectiveCSpyable
@end


// Inheriting subclasses

@interface FirstInheritingObjectiveCSpyable: RootObjectiveCSpyable
@end

@interface SecondInheritingObjectiveCSpyable: FirstInheritingObjectiveCSpyable
@end


//  Hybrid subclasses

@interface InheritingObjectiveCSpyableOverrider: FirstInheritingObjectiveCSpyable
@end

@interface OverridingObjectiveCSpyableInheritor: FirstOverridingObjectiveCSpyable
@end
