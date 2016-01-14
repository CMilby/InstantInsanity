//
//  OverlayShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "OverlayShader.h"

#import <c++/v1/vector>

@implementation OverlayShader {
    
}

typedef struct {
    float x;
    float y;
} Vector2;

- ( id ) init {
    if ( self = [ super init: @"OverlayShader" withFrag: @"OverlayShader" ] ) {
        glGenBuffers( 1, &m_vertexBuffer );
        glGenBuffers( 1, &m_uvBuffer );
        
        [ self addUniform: @"sampler" ];
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
}

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withSize: ( int ) size {
    // Take tex coords
    // Translate by x and y coords
    // Uvs stay the same
    // bind buffers
    // buffer data
    // uniforms
    // draw
    
    std::vector<Vector2> vertices;
    std::vector<Vector2> uvs;
    
    Vector2 vertex_up_left;
    vertex_up_left.x = x;
    vertex_up_left.y = y + size;
    
    Vector2 vertex_up_right;
    vertex_up_right.x = x + size;
    vertex_up_right.y = y + size;
    
    Vector2 vertex_down_left;
    vertex_down_left.x = x;
    vertex_down_left.y = y;
    
    Vector2 vertex_down_right;
    vertex_down_right.x = x + size;
    vertex_down_right.y = y;
    
    vertices.push_back( vertex_up_left );
    vertices.push_back( vertex_down_left );
    vertices.push_back( vertex_up_right );
    
    vertices.push_back( vertex_down_right );
    vertices.push_back( vertex_up_right );
    vertices.push_back( vertex_down_left );
    
    Vector2 uv_up_left;
    uv_up_left.x = 0.000000;
    uv_up_left.y = 1.000000;

    Vector2 uv_up_right;
    uv_up_right.x = 1.000000;
    uv_up_right.y = 1.000000;
    
    Vector2 uv_down_left;
    uv_down_left.x = 0.000000;
    uv_down_left.y = 0.000000;
    
    Vector2 uv_down_right;
    uv_down_right.x = 1.000000;
    uv_down_right.y = 0.000000;
    
    uvs.push_back( uv_up_left );
    uvs.push_back( uv_down_left );
    uvs.push_back( uv_up_right );
    
    uvs.push_back( uv_down_right );
    uvs.push_back( uv_up_right );
    uvs.push_back( uv_down_left );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glBufferData( GL_ARRAY_BUFFER, vertices.size() * sizeof( Vector2 ), &vertices[ 0 ], GL_STATIC_DRAW );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_uvBuffer );
    glBufferData( GL_ARRAY_BUFFER, uvs.size() * sizeof( Vector2 ), &uvs[ 0 ], GL_STATIC_DRAW );
    
    [ self bind ];
    
    [ texture bind ];
    [ self updateUniform: @"sampler" withInt: 0 ];
    
    glEnableVertexAttribArray( GLKVertexAttribPosition );
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glVertexAttribPointer( GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, ( GLvoid* ) 0 );
    
    glEnableVertexAttribArray( GLKVertexAttribTexCoord0 );
    glBindBuffer( GL_ARRAY_BUFFER, m_uvBuffer );
    glVertexAttribPointer( GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, ( GLvoid* ) 0 );
    
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    glDrawArrays( GL_TRIANGLES, 0, ( GLuint ) vertices.size() );
    
    glDisable( GL_BLEND );
    
    glDisableVertexAttribArray( GLKVertexAttribPosition );
    glDisableVertexAttribArray( GLKVertexAttribTexCoord0 );
}

@end











