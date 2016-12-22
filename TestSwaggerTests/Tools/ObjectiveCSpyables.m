//
//  ObjectiveCSpyables.m
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import "ObjectiveCSpyables.h"


//  Well-known return values

NSInteger const RootMethodReturnValue = 14;
NSInteger const FirstOverridingMethodReturnValue = 42;
NSInteger const SecondOverridingMethodReturnValue = 99;


//  Root sample class

@implementation RootObjectiveCSpyable

+ (NSInteger)sampleMethod:(NSString *)input {
    return RootMethodReturnValue;
}

- (NSInteger)sampleMethod:(NSString *)input {
    return RootMethodReturnValue;
}

@end


// Overriding subclasses

@implementation FirstOverridingObjectiveCSpyable

+ (NSInteger)sampleMethod:(NSString *)input {
    return FirstOverridingMethodReturnValue;
}

- (NSInteger)sampleMethod:(NSString *)input {
    return FirstOverridingMethodReturnValue;
}

@end

@implementation SecondOverridingObjectiveCSpyable

+ (NSInteger)sampleMethod:(NSString *)input {
    return SecondOverridingMethodReturnValue;
}

- (NSInteger)sampleMethod:(NSString *)input {
    return SecondOverridingMethodReturnValue;
}

@end


// Inheriting subclasses

@implementation FirstInheritingObjectiveCSpyable : RootObjectiveCSpyable
@end

@implementation SecondInheritingObjectiveCSpyable : FirstInheritingObjectiveCSpyable
@end


//  Hybrid subclasses

@implementation InheritingObjectiveCSpyableOverrider : FirstInheritingObjectiveCSpyable

+ (NSInteger)sampleMethod:(NSString *)input {
    return SecondOverridingMethodReturnValue;
}

- (NSInteger)sampleMethod:(NSString *)input {
    return SecondOverridingMethodReturnValue;
}

@end

@implementation OverridingObjectiveCSpyableInheritor : FirstOverridingObjectiveCSpyable
@end
