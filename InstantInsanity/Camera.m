//
//  Camera.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Camera.h"

#include "Constants.h"

@implementation Camera {
    
}

- ( id ) init: ( GLKVector3 ) lookAt {
    if ( self = [ super init ] ) {
        m_lookAt = lookAt;
        m_isRotating = false;
        m_isZooming = false;
        m_lastFingerPosition = GLKVector2Make( 0.0f, 0.0f );
        m_currentFingerPosition = GLKVector2Make( 0.0f, 0.0f );
        m_currentDistance = 5.0f;
        m_lastDistance = 0.0f;
        [ self reset ];
    }
    return self;
}

- ( void ) reset {
    m_currentViewPosition = GLKVector3Make( 0.0f, 0.0f, 0.0f );
    m_rotation = GLKQuaternionIdentity;
}

- ( void ) setup: ( float ) xAngle yAngle: ( float ) yAngle distance: ( float ) distance {
    m_currentDistance = distance;
    m_angles.x = xAngle;
    m_angles.y = yAngle;
    
    // Lock
    if ( m_angles.y > CAMERA_ANGLE ) m_angles.y = CAMERA_ANGLE;
    if ( m_angles.y < -CAMERA_ANGLE) m_angles.y = -CAMERA_ANGLE;
    
    GLKQuaternion q1 = GLKQuaternionMakeWithAngleAndVector3Axis( GLKMathDegreesToRadians( m_angles.x ), GLKVector3Make( 0.0f, 1.0f, 0.0f ) );
    GLKQuaternion q2 = GLKQuaternionMakeWithAngleAndVector3Axis( GLKMathDegreesToRadians( m_angles.y ), GLKVector3Make( 1.0f, 0.0f, 0.0f ) );
    m_rotation = GLKQuaternionMultiply( q1, q2 );
}

- ( void ) startRotation: ( float ) xPos yPos: ( float ) yPos {
    if ( m_isZooming || m_isRotating )
        return;
    
    m_lastFingerPosition = GLKVector2Make( xPos, yPos );
    m_currentFingerPosition = m_lastFingerPosition;
    
    m_isRotating = true;
}

- ( void ) updateRotation: ( float ) xPos yPos: ( float ) yPos {
    if ( m_isRotating ) {
        m_currentFingerPosition = GLKVector2Make( xPos, yPos );
    }
}

- ( void ) stopRotation {
    m_isRotating = false;
}

- ( void ) startZooming: ( float ) d {
    if ( m_isRotating || m_isZooming )
        return;
    
    m_lastDistance = d;
    m_isZooming = true;
}

- ( void ) updateZooming: ( float ) d {
    if ( m_isZooming ) {
        float delta = m_lastDistance - d;
        m_currentDistance += delta * ZOOM_SPEED;
        
        if ( m_currentDistance < MIN_ZOOM ) m_currentDistance = MIN_ZOOM;
        if ( m_currentDistance > MAX_ZOOM ) m_currentDistance = MAX_ZOOM;
        
        m_lastDistance = d;
    }
    // NSLog( @"%f", m_currentDistance );
}

- ( void ) stopZooming {
    m_isZooming = false;
}

- ( void ) updateView {
    if ( m_isRotating ) {
        GLKVector2 delta = GLKVector2Subtract( m_currentFingerPosition, m_lastFingerPosition );
        if ( fabsf( delta.x ) > 1E-5 || fabsf( delta.y ) > 1E-5 ) {
            GLKVector2 oldAngles = m_angles;
            m_angles.x += delta.x * ROTATION_SPEED;
            m_angles.y -= delta.y * ROTATION_SPEED;
            
            if ( m_angles.y > CAMERA_ANGLE ) m_angles.y = CAMERA_ANGLE;
            if ( m_angles.y < -CAMERA_ANGLE ) m_angles.y = -CAMERA_ANGLE;
            
            if ( fabsf( oldAngles.x - m_angles.x ) > 1E-5 || fabsf( oldAngles.y - m_angles.y ) > 1E-5 ) {
                GLKQuaternion q1 = GLKQuaternionMakeWithAngleAndVector3Axis( GLKMathDegreesToRadians( m_angles.x ), GLKVector3Make( 0.0f, 1.0f, 0.0f ) );
                GLKQuaternion q2 = GLKQuaternionMakeWithAngleAndVector3Axis( GLKMathDegreesToRadians( m_angles.y ), GLKVector3Make( 1.0f, 0.0f, 0.0f ) );
                m_rotation = GLKQuaternionMultiply( q1, q2 );
            }
            m_lastFingerPosition = m_currentFingerPosition;
        }
    }

    GLKVector3 v = [ IIMath zDirection: m_rotation ];
    m_currentViewPosition = GLKVector3MultiplyScalar( GLKVector3Make( v.x, v.y, v.z ), m_currentDistance );
}

- ( GLKMatrix4 ) getViewMatrix {
    return GLKMatrix4MakeLookAt( m_currentViewPosition.x, m_currentViewPosition.y, m_currentViewPosition.z, m_lookAt.x, m_lookAt.y, m_lookAt.z, 0.0f, 1.0f, 0.0f );
}

- ( GLKVector2 ) getLastFingerPosition {
    return m_lastFingerPosition;
}

- ( bool ) isRotatingNow {
    return m_isRotating;
}

- ( bool ) isZoomingNow {
    return m_isZooming;
}

- ( GLKVector3 ) getCurrentViewPosition {
    return m_currentViewPosition;
}

@end