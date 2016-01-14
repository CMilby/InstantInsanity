//
//  Camera.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CAMERA_H__
#define __CAMERA_H__

#import <GLKit/GLKit.h>

@interface Camera : NSObject {
    GLKVector3 m_lookAt;
    
    bool m_isRotating;
    GLKVector2 m_lastFingerPosition;
    GLKVector2 m_currentFingerPosition;
    GLKVector2 m_angles;
    GLKQuaternion m_rotation;
    
    bool m_isZooming;
    float m_lastDistance;
    float m_currentDistance;
    
    GLKVector3 m_currentViewPosition;
}

- ( id ) init: ( GLKVector3 ) lookAt;

- ( void ) setup: ( float ) xAngle yAngle: ( float ) yAngle distance: ( float ) distance;

- ( void ) startRotation: ( float ) xPos yPos: ( float ) yPos;

- ( void ) updateRotation: ( float ) xPos yPos: ( float ) yPos;

- ( void ) stopRotation;

- ( void ) startZooming: ( float ) d;

- ( void ) updateZooming: ( float ) d;

- ( void ) stopZooming;

- ( void ) updateView;

- ( GLKMatrix4 ) getViewMatrix;

- ( GLKVector3 ) getCurrentViewPosition;

- ( GLKVector2 ) getLastFingerPosition;

- ( bool ) isRotatingNow;

- ( bool ) isZoomingNow;

- ( void ) reset;

- ( GLKQuaternion ) getRotation;

@end

#endif /* Camera_h */
