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

+ ( GLKVector3 ) zDirection: ( GLKQuaternion ) quat;

@end

#endif /* Math_h */
