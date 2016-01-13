//
//  Transform.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Transform.h"

@implementation Transform {

}

- ( id ) init {
    if ( self = [ super init ] ) {
        m_position = GLKVector3Make( 0.0, 0.0, 0.0 );
        m_scale = GLKVector3Make( 1.0, 1.0, 1.0 );
        m_rotation = GLKQuaternionMake( 0.0, 0.0, 0.0, 1.0 );
        // m_rotation = GLKMatrix4Identity;
        
        m_projectionMatrix = GLKMatrix4MakePerspective( GLKMathDegreesToRadians( 70.0f ), [ UIScreen mainScreen ].bounds.size.width / [ UIScreen mainScreen ].bounds.size.height, 0.1f, 100.0f );
    }
    return self;
}

- ( id ) init: ( GLKVector3 ) position {
    if ( self = [ super init ] ) {
        m_position = position;
        m_scale = GLKVector3Make( 1.0, 1.0, 1.0 );
        m_rotation = GLKQuaternionMake( 0.0, 0.0, 0.0, 1.0 );
        // m_rotation = GLKMatrix4Identity;
        
        m_projectionMatrix = GLKMatrix4MakePerspective( GLKMathDegreesToRadians( 70.0f ), [ UIScreen mainScreen ].bounds.size.width / [ UIScreen mainScreen ].bounds.size.height, 0.1f, 100.0f );
    }
    return self;
}

- ( id ) init: ( GLKVector3 ) position withScale: ( GLKVector3 ) scale withRotation: ( GLKQuaternion ) rotation {
    if ( self = [ super init ] ) {
        m_position = position;
        m_scale = scale;
        m_rotation = rotation;
        // m_rotation = GLKMatrix4Identity;
        
        m_projectionMatrix = GLKMatrix4MakePerspective( GLKMathDegreesToRadians( 70.0f ), [ UIScreen mainScreen ].bounds.size.width / [ UIScreen mainScreen ].bounds.size.height, 0.1f, 100.0f );
    }
    return self;
}

- ( GLKVector3 ) getPosition {
    return m_position;
}

- ( GLKVector3 ) getScale {
    return m_scale;
}

- ( GLKQuaternion ) getRotation {
    return m_rotation;
}

- ( void ) setPosition: ( GLKVector3 ) position {
    m_position = position;
}

- ( void ) setScale: ( GLKVector3 ) scale {
    m_scale = scale;
}

- ( void ) setRotation: ( GLKQuaternion ) rotation {
    m_rotation = rotation;
}

- ( void ) rotate: ( GLKVector3 ) axis withAngle: ( GLfloat ) angle {
    // THIS WILL ROTATE AROUND THE WORLD AXIS
    m_rotation = GLKQuaternionMultiply( GLKQuaternionMakeWithAngleAndAxis( GLKMathDegreesToRadians( angle ), axis.x, axis.y, axis.z ), m_rotation );
    
    
    // THIS WILL ROTATE AROUD THE LOCAL AXIS
    // m_rotation = GLKQuaternionMultiply( m_rotation, GLKQuaternionMakeWithAngleAndAxis( GLKMathDegreesToRadians( angle ), axis.x, axis.y, axis.z ) );
}

- ( void ) rotate: ( GLKQuaternion ) quat {
    // m_rotation = GLKQuaternionNormalize( GLKQuaternionMultiply( GLKQuaternionMakeWithMatrix4( m_rotation ), quat ) );
}

- ( GLKMatrix4 ) getModelMatrix {
    GLKMatrix4 translation = GLKMatrix4MakeTranslation( m_position.x, m_position.y, m_position.z );
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    GLKMatrix4 scale = GLKMatrix4MakeScale( m_scale.x, m_scale.y, m_scale.z );
    return GLKMatrix4Multiply( GLKMatrix4Multiply( translation, rotation), scale );
}

- ( GLKMatrix4 ) getProjectionMatrix {
    return m_projectionMatrix;
}

- ( GLKVector3 ) getForward {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( -rotation.m[ 8 ], -rotation.m[ 9 ], -rotation.m[ 10 ] );
}

- ( GLKVector3 ) getBack {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( rotation.m[ 8 ], rotation.m[ 9 ], rotation.m[ 10 ] );
}

- ( GLKVector3 ) getRight {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( rotation.m[ 0 ], rotation.m[ 1 ], rotation.m[ 2 ] );
}

- ( GLKVector3 ) getLeft {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( -rotation.m[ 0 ], -rotation.m[ 1 ], -rotation.m[ 2 ] );
}

- ( GLKVector3 ) getUp {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( rotation.m[ 4 ], rotation.m[ 5 ], rotation.m[ 6 ] );
}

- ( GLKVector3 ) getDown {
    GLKMatrix4 rotation = GLKMatrix4MakeWithQuaternion( m_rotation );
    return GLKVector3Make( -rotation.m[ 4 ], -rotation.m[ 5 ], -rotation.m[ 6 ] );
}

@end














