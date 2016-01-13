//
//  Transform.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __TRANSFORM_H__
#define __TRANSFORM_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface Transform : NSObject {
    GLKVector3 m_position;
    GLKVector3 m_scale;
    GLKQuaternion m_rotation;
    // GLKMatrix4 m_rotation;
    
    GLKMatrix4 m_projectionMatrix;
}

- ( id ) init;

- ( id ) init: ( GLKVector3 ) position;

- ( id ) init: ( GLKVector3 ) position withScale: ( GLKVector3 ) scale withRotation: ( GLKQuaternion ) rotation;

- ( GLKVector3 ) getPosition;

- ( GLKVector3 ) getScale;

- ( GLKQuaternion ) getRotation;

- ( void ) setPosition: ( GLKVector3 ) position;

- ( void ) setScale: ( GLKVector3 ) scale;

- ( void ) setRotation: ( GLKQuaternion ) rotation;

- ( void ) rotate: ( GLKVector3 ) axis withAngle: ( GLfloat ) angle;

- ( void ) rotate: ( GLKQuaternion ) quat;

- ( GLKMatrix4 ) getModelMatrix;

- ( GLKMatrix4 ) getProjectionMatrix;

- ( GLKVector3 ) getForward;

- ( GLKVector3 ) getBack;

- ( GLKVector3 ) getRight;

- ( GLKVector3 ) getLeft;

- ( GLKVector3 ) getUp;

- ( GLKVector3 ) getDown;

@end

#endif /* Transform_h */
