//
//  Cube.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Cube.h"

@implementation Cube {
    
}

- ( id ) init: ( NSString* ) textureFile {
    if ( self = [ super init: [ [ Mesh alloc ] init: g_vertices withVertexSize: sizeof( g_vertices ) withUVs: g_texCoords withUVSize: sizeof( g_texCoords ) withNormals: g_normals withNormalSize:sizeof( g_normals ) ] withTexture: [ [ Texture alloc ] init: textureFile ] withTransform:[ [ Transform alloc ] init: GLKVector3Make( 0.0, 0.0, 0.0 ) ] ] ) {
    }
    return self;
}

- ( int ) frontColor {
    return m_frontColor;
}

- ( int ) backColor {
    return m_backColor;
}

- ( int ) leftColor {
    return m_leftColor;
}

- ( int ) rightColor {
    return m_rightColor;
}

- ( int ) topColor {
    return m_topColor;
}

- ( int ) bottomColor {
    return m_bottomColor;
}

- ( int ) color: ( int ) index {
    switch ( index ) {
        case 0:
            return m_frontColor;
        case 1:
            return m_backColor;
        case 2:
            return m_leftColor;
        case 3:
            return m_rightColor;
        case 4:
            return m_topColor;
        case 5:
            return m_bottomColor;
    }
    return -1;
}

- ( void ) setFrontColor: ( int ) color {
    m_frontColor = color;
}

- ( void ) setBackColor: ( int ) color {
    m_backColor = color;
}

- ( void ) setLeftColor: ( int ) color {
    m_leftColor = color;
}

- ( void ) setRightColor: ( int ) color {
    m_rightColor = color;
}
- ( void ) setTopColor: ( int ) color {
    m_topColor = color;
}

- ( void ) setBottomColor: ( int ) color {
    m_bottomColor = color;
}

- ( void ) rotateX: ( bool ) clockwise {
    int temp = m_frontColor;
    if ( clockwise ) {
        m_frontColor = m_bottomColor;
        m_bottomColor = m_backColor;
        m_backColor = m_topColor;
        m_topColor = temp;
    } else {
        m_frontColor = m_topColor;
        m_topColor = m_backColor;
        m_backColor = m_bottomColor;
        m_bottomColor = temp;
    }
}

- ( void ) rotateY: ( bool ) clockwise {
    int temp = m_frontColor;
    if ( clockwise ) {
        m_frontColor = m_rightColor;
        m_rightColor = m_backColor;
        m_backColor = m_leftColor;
        m_leftColor = temp;
    } else {
        m_frontColor = m_leftColor;
        m_leftColor = m_backColor;
        m_backColor = m_rightColor;
        m_rightColor = temp;
    }
}

- ( void ) rotateZ: ( bool ) clockwise {
    int temp = m_topColor;
    if ( clockwise ) {
        m_topColor = m_leftColor;
        m_leftColor = m_bottomColor;
        m_bottomColor = m_rightColor;
        m_rightColor = temp;
    } else {
        m_topColor = m_rightColor;
        m_rightColor = m_bottomColor;
        m_bottomColor = m_leftColor;
        m_leftColor = temp;
    }
}

GLfloat g_vertices[] = {
    
     // Back
     1.000000,  1.000000, -1.000000,
     1.000000, -1.000000, -1.000000,
    -1.000000, -1.000000, -1.000000,
     1.000000,  1.000000, -1.000000,
    -1.000000, -1.000000, -1.000000,
    -1.000000,  1.000000, -1.000000,
    
     // Left
    -1.000000, -1.000000,  1.000000,
    -1.000000,  1.000000,  1.000000,
    -1.000000,  1.000000, -1.000000,
    -1.000000, -1.000000,  1.000000,
    -1.000000,  1.000000, -1.000000,
    -1.000000, -1.000000, -1.000000,
    
     // Front
     1.000000, -1.000000,  1.000000,
     1.000000,  1.000000,  1.000000,
    -1.000000, -1.000000,  1.000000,
     1.000000,  1.000000,  1.000000,
    -1.000000,  1.000000,  1.000000,
    -1.000000, -1.000000,  1.000000,
    
     // Right
     1.000000, -1.000000, -1.000000,
     1.000000,  1.000000, -1.000000,
     1.000000, -1.000000,  1.000000,
     1.000000,  1.000000, -1.000000,
     1.000000,  1.000000,  1.000000,
     1.000000, -1.000000,  1.000000,
    
     // Top
     1.000000,  1.000000, -1.000000,
    -1.000000,  1.000000, -1.000000,
     1.000000,  1.000000,  1.000000,
    -1.000000,  1.000000, -1.000000,
    -1.000000,  1.000000,  1.000000,
     1.000000,  1.000000,  1.000000,
    
     // Bottom
     1.000000, -1.000000, -1.000000,
     1.000000, -1.000000,  1.000000,
    -1.000000, -1.000000,  1.000000,
     1.000000, -1.000000, -1.000000,
    -1.000000, -1.000000,  1.000000,
    -1.000000, -1.000000, -1.000000
};

GLfloat g_texCoords[] = {
    
    // Back
    0.500000, 0.250000,
    0.500000, 0.000000,
    0.250000, 0.000000,
    0.500000, 0.250000,
    0.250000, 0.000000,
    0.250000, 0.250000,
    
    // Left
    0.500000, 0.250000,
    0.750000, 0.250000,
    0.750000, 0.000000,
    0.500000, 0.250000,
    0.750000, 0.000000,
    0.500000, 0.000000,
    
    // Front
    0.250000, 0.000000,
    0.250000, 0.250000,
    0.000000, 0.000000,
    0.250000, 0.250000,
    0.000000, 0.250000,
    0.000000, 0.000000,
    
    // Right
    0.750000, 0.000000,
    1.000000, 0.000000,
    0.750000, 0.250000,
    1.000000, 0.250000,
    1.000000, 0.000000,
    0.750000, 0.250000,

    // Top
    0.250000, 0.250000,
    0.000000, 0.250000,
    0.250000, 0.500000,
    0.000000, 0.250000,
    0.000000, 0.500000,
    0.250000, 0.500000,
    
    // Bottom
    0.500000, 0.250000,
    0.500000, 0.500000,
    0.250000, 0.500000,
    0.500000, 0.250000,
    0.250000, 0.500000,
    0.250000, 0.250000
};

GLfloat g_normals[] = {
    
     // Back
     0.000000,  0.000000, -1.000000,
     0.000000,  0.000000, -1.000000,
     0.000000,  0.000000, -1.000000,
     0.000000,  0.000000, -1.000000,
     0.000000,  0.000000, -1.000000,
     0.000000,  0.000000, -1.000000,
    
     // Left
    -1.000000, -0.000000, -0.000000,
    -1.000000, -0.000000, -0.000000,
    -1.000000, -0.000000, -0.000000,
    -1.000000, -0.000000, -0.000000,
    -1.000000, -0.000000, -0.000000,
    -1.000000, -0.000000, -0.000000,
    
     // Front
    -0.000000, -0.000000,  1.000000,
    -0.000000, -0.000000,  1.000000,
    -0.000000, -0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000,
    -0.000000,  0.000000,  1.000000,
    
     // Right
     1.000000, -0.000000,  0.000000,
     1.000000, -0.000000,  0.000000,
     1.000000, -0.000000,  0.000000,
     1.000000,  0.000000,  0.000000,
     1.000000,  0.000000,  0.000000,
     1.000000,  0.000000,  0.000000,
    
     // Top
     0.000000,  1.000000, -0.000000,
     0.000000,  1.000000, -0.000000,
     0.000000,  1.000000, -0.000000,
     0.000000,  1.000000, -0.000000,
     0.000000,  1.000000, -0.000000,
     0.000000,  1.000000, -0.000000,
    
     // Bottom
    -0.000000, -1.000000,  0.000000,
    -0.000000, -1.000000,  0.000000,
    -0.000000, -1.000000,  0.000000,
    -0.000000, -1.000000,  0.000000,
    -0.000000, -1.000000,  0.000000,
    -0.000000, -1.000000,  0.000000
};

@end
