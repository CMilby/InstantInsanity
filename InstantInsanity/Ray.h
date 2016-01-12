//
//  Ray.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/10/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __RAY_H__
#define __RAY_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Ray : NSObject {
    GLKVector3 m_origin;
    GLKVector3 m_direction;
}

- ( id ) init;

- ( id ) init: ( GLKVector3 ) origin inDirection: ( GLKVector3 ) direction;

- ( GLKVector3 ) getDirection;

- ( GLKVector3 ) getOrigin;

@end

#endif /* Ray_h */
