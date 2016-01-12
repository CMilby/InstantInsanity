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

- ( id ) init {
    if ( self = [ super init ] ) {
        
    }
    return self;
}

+ ( GLKMatrix4 ) toRotationMatrix: ( GLKQuaternion ) quat {
    float forwardX = 2.0f * ( quat.x * quat.z - quat.w * quat.y );
    float forwardY = 2.0f * ( quat.y * quat.z + quat.w * quat.x );
    float forwardZ = 1.0f - 2.0f * ( quat.x * quat.x + quat.y * quat.y );
    
    float upX = 2.0f * ( quat.x * quat.y + quat.w * quat.z );
    float upY = 1.0f - 2.0f * ( quat.x * quat.x + quat.z * quat.z );
    float upZ = 2.0f * ( quat.y * quat.z - quat.w * quat.x );
    
    float rightX = 1.0f - 2.0f * ( quat.y * quat.y + quat.z * quat.z );
    float rightY = 2.0f * ( quat.x * quat.y - quat.w * quat.z );
    float rightZ = 2.0f * ( quat.x * quat.z + quat.w * quat.y );
    
    return [ self rotationFromVectors: GLKVector3Make( forwardX, forwardY, forwardZ ) withV: GLKVector3Make( upX, upY, upZ ) withU: GLKVector3Make( rightX, rightY, rightZ ) ] ;
}

+ ( GLKMatrix4 ) rotationFromVectors: ( GLKVector3 ) n withV: ( GLKVector3 ) v withU: ( GLKVector3 ) u {
    GLKMatrix4 ret = GLKMatrix4Identity;
    ret.m[ 0 ] = u.x;
    ret.m[ 4 ] = u.y;
    ret.m[ 8 ] = u.z;
    
    ret.m[ 1 ] = v.x;
    ret.m[ 5 ] = v.y;
    ret.m[ 9 ] = v.z;
    
    ret.m[ 2 ]  = n.x;
    ret.m[ 6 ]  = n.y;
    ret.m[ 10 ] = n.z;
    
    return ret;
}

+ ( GLKVector3 ) zDirection: ( GLKQuaternion ) quat {
    GLKVector3 vect = GLKVector3Make( 0.0f, 0.0f, 0.0f );
    vect.x = 2 * quat.w * quat.y + 2 * quat.x * quat.z;
    vect.y = 2 * quat.y * quat.z - 2 * quat.x * quat.w;
    vect.z = quat.w * quat.w + quat.z * quat.z - quat.x * quat.x - quat.y * quat.y;
    return vect;
}

+ ( GLKMatrix4 ) eulerToMatrix: ( float ) heading withAttitude: ( float ) attitude withBank: ( float ) bank {
    GLKMatrix4 mat = GLKMatrix4Identity;
    
    float ch = cosf( GLKMathDegreesToRadians( heading ) );
    float sh = sinf( GLKMathDegreesToRadians( heading ) );
    float ca = cosf( GLKMathDegreesToRadians( attitude ) );
    float sa = sinf( GLKMathDegreesToRadians( attitude ) );
    float cb = cosf( GLKMathDegreesToRadians( bank ) );
    float sb = sinf( GLKMathDegreesToRadians( bank ) );
    
    mat.m00 = ch * ca;
    mat.m01 = sh * sb - ch * sa * cb;
    mat.m02 = ch * sa * sb + sh * cb;
    
    mat.m10 = sa;
    mat.m11 = ca * cb;
    mat.m12 = -ca * sb;
    
    mat.m20 = -sh * ca;
    mat.m21 = sh * sa * cb + ch * sb;
    mat.m22 = -sh * sa * sb + ch * cb;
    
    return mat;
}

@end


















