//
//  OverlaySelectionShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "OverlaySelectionShader.h"

#import <c++/v1/vector>

@implementation OverlaySelectionShader {
    
}

typedef struct {
    float x;
    float y;
} Vector2;

- ( id ) init {
    if ( self = [ super init: @"OverlaySelectionShader" withFrag: @"OverlaySelectionShader" ] ) {
        [ self addUniform: @"code" ];
    }
    return self;
}

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withWidth: ( int ) width withHeight: ( int ) height {
    if ( m_vertexBuffer == 0 ) {
        glGenBuffers( 1, &m_vertexBuffer );
    }
    
    std::vector<Vector2> vertices;
    std::vector<Vector2> uvs;
    
    Vector2 vertex_up_left;
    vertex_up_left.x = x;
    vertex_up_left.y = y + height;
    
    Vector2 vertex_up_right;
    vertex_up_right.x = x + width;
    vertex_up_right.y = y + height;
    
    Vector2 vertex_down_left;
    vertex_down_left.x = x;
    vertex_down_left.y = y;
    
    Vector2 vertex_down_right;
    vertex_down_right.x = x + width;
    vertex_down_right.y = y;
    
    vertices.push_back( vertex_up_left );
    vertices.push_back( vertex_down_left );
    vertices.push_back( vertex_up_right );
    
    vertices.push_back( vertex_down_right );
    vertices.push_back( vertex_up_right );
    vertices.push_back( vertex_down_left );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glBufferData( GL_ARRAY_BUFFER, vertices.size() * sizeof( Vector2 ), &vertices[ 0 ], GL_STATIC_DRAW );
    
    [ self bind ];
    [ self updateUniform: @"code" withFloat: [ texture getCode ] ];
    
    glEnableVertexAttribArray( GLKVertexAttribPosition );
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glVertexAttribPointer( GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, 0, ( GLvoid* ) 0 );
    
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    glDrawArrays( GL_TRIANGLES, 0, ( GLuint ) vertices.size() );
    
    glDisable( GL_BLEND );
    
    glDisableVertexAttribArray( GLKVertexAttribPosition );
}

@end