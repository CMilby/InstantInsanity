//
//  Plane.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Plane.h"

@implementation Plane {
    
}

- ( id ) init: ( NSString* ) textureFile {
    if ( self = [ super init: [ [ Mesh alloc ] init: g_planeVertices withVertexSize: sizeof( g_planeVertices ) withUVs: g_planeTexCoords withUVSize: sizeof( g_planeTexCoords ) withNormals: g_planeNormals withNormalSize:sizeof( g_planeNormals ) ] withTexture: [ [ Texture alloc ] init: textureFile ] withTransform:[ [ Transform alloc ] init: GLKVector3Make( 0.0, 0.0, 0.0 ) ] ] ) {
        
    }
    return self;
}

GLfloat g_planeVertices[] = {
     1.000000, -1.000000,  0.000000,
     1.000000,  1.000000,  0.000000,
    -1.000000, -1.000000,  0.000000,
     1.000000,  1.000000,  0.000000,
    -1.000000,  1.000000,  0.000000,
    -1.000000, -1.000000,  0.000000
};

GLfloat g_planeTexCoords[] = {
    0.000000, 1.000000,
    0.000000, 0.000000,
    1.000000, 1.000000,
    0.000000, 0.000000,
    1.000000, 0.000000,
    1.000000, 1.000000
};

GLfloat g_planeNormals[] = {
    -0.000000, -0.000000,  1.000000,
    -0.000000, -0.000000,  1.000000,
    -0.000000, -0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000
};

GLfloat g_planeVerts[] = {
    -1.000000,  1.000000, 0.000000,
     1.000000,  1.000000, 0.000000,
    -1.000000, -1.000000, 0.000000,
     1.000000, -1.000000, 0.000000
};

GLfloat g_planeUVS[] = {
    1.000000, 0.000000,
    0.000000, 0.000000,
    1.000000, 1.000000,
    0.000000, 1.000000
};

@end