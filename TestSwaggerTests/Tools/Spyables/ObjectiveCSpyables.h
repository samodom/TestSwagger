//
//  ObjectiveCSpyables.h
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

@import Foundation;
@import TestSwagger;


//  Well-known return values

FOUNDATION_EXPORT NSInteger const NormalMethodReturnValueAtRoot;
FOUNDATION_EXPORT NSInteger const NormalMethodReturnValueOverridenAtLevel1;
FOUNDATION_EXPORT NSInteger const NormalMethodReturnValueOverridenAtLevel2;

FOUNDATION_EXPORT NSInteger const SpyMethodReturnValue;


//  Root sample class

@interface ObjectiveCRootSpyable : NSObject

+ (BOOL)callsSuperclass;
+ (void)setCallsSuperclass:(BOOL)callsSuperclass;
+ (NSInteger)sampleClassMethod:(NSString *)input;
- (NSInteger)sampleInstanceMethod:(NSString *)input;

@end


// Overriding subclasses

@interface ObjectiveCOverrider: ObjectiveCRootSpyable
@end

@interface ObjectiveCOverriderOfOverrider: ObjectiveCOverrider
@end


// Inheriting subclasses

@interface ObjectiveCInheritor: ObjectiveCRootSpyable
@end

@interface ObjectiveCInheritorOfInheritor: ObjectiveCInheritor
@end


//  Hybrid subclasses

@interface ObjectiveCOverriderOfInheritor: ObjectiveCInheritor
@end

@interface ObjectiveCInheritorOfOverrider: ObjectiveCOverrider
@end
