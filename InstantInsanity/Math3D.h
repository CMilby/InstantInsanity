//
//  Math.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __MATH_3D_H__
#define __MATH_3D_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface IIMath : NSObject {
    
}

- ( id ) init;

+ ( GLKMatrix4 ) toRotationMatrix: ( GLKQuaternion ) quat;

+ ( GLKMatrix4 ) rotationFromVectors: ( GLKVector3 ) n withV: ( GLKVector3 ) v withU: ( GLKVector3 ) u;

+ ( GLKVector3 ) zDirection: ( GLKQuaternion ) quat;

+ ( GLKMatrix4 ) eulerToMatrix: ( float ) heading withAttitude: ( float ) attitude withBank: ( float ) bank;

@end

#endif /* Math_h */
