//
//  Math.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Math3D.h"

@implementation IIMath {
    
}

+ ( GLKVector3 ) zDirection: ( GLKQuaternion ) quat {
    GLKVector3 vect = GLKVector3Make( 0.0f, 0.0f, 0.0f );
    vect.x = 2 * quat.w * quat.y + 2 * quat.x * quat.z;
    vect.y = 2 * quat.y * quat.z - 2 * quat.x * quat.w;
    vect.z = quat.w * quat.w + quat.z * quat.z - quat.x * quat.x - quat.y * quat.y;
    return vect;
}

@end


















