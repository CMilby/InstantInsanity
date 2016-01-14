//
//  TextShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/12/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "TextShader.h"

#import <c++/v1/vector>

#include "Constants.h"

@implementation TextShader {

}

typedef struct {
    float x;
    float y;
} Vector2;

- ( id ) init: ( NSString* ) textureFile {
    if ( self = [ super init: @"TextShader" withFrag: @"TextShader" ] ) {
        m_texture = [ [ Texture alloc ] init: textureFile ];
        
        glGenBuffers( 1, &m_vertexBuffer );
        glGenBuffers( 1, &m_uvBuffer );
    
        [ self addUniform: @"sampler" ];
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
    
    if ( m_vertexBuffer ) {
        glDeleteBuffers( 1, &m_vertexBuffer );
        m_vertexBuffer = 0;
    }
    
    if ( m_uvBuffer ) {
        glDeleteBuffers( 1, &m_uvBuffer );
        m_uvBuffer = 0;
    }
}

- ( void ) updateString: ( NSString* ) text withX: ( int ) x withY: ( int ) y withSize: ( int ) size {
    std::vector<Vector2> vertices;
    std::vector<Vector2> uvs;
    
    for ( unsigned int i = 0; i < [ text length ]; i++ ) {
        Vector2 vertex_up_left;
        vertex_up_left.x = x + i * size;
        vertex_up_left.y = y + size;
        
        Vector2 vertex_up_right;
        vertex_up_right.x = x + i * size + size;
        vertex_up_right.y = y + size;
        
        Vector2 vertex_down_right;
        vertex_down_right.x = x + i * size + size;
        vertex_down_right.y = y;
        
        Vector2 vertex_down_left;
        vertex_down_left.x = x + i * size;
        vertex_down_left.y = y;
     
        vertices.push_back( vertex_up_left );
        vertices.push_back( vertex_down_left );
        vertices.push_back( vertex_up_right );
        
        vertices.push_back( vertex_down_right );
        vertices.push_back( vertex_up_right );
        vertices.push_back( vertex_down_left );
        
        char character = [ text characterAtIndex: i ];
        float uv_x = ( character % ( int ) FONT_SIZE ) / FONT_SIZE;
        float uv_y = ( character / ( int ) FONT_SIZE ) / FONT_SIZE;
        
        Vector2 uv_up_left;
        uv_up_left.x = uv_x;
        uv_up_left.y = uv_y;
        
        Vector2 uv_up_right;
        uv_up_right.x = uv_x + 1.0f / FONT_SIZE;
        uv_up_right.y = uv_y;
        
        Vector2 uv_down_right;
        uv_down_right.x = uv_x + 1.0f / FONT_SIZE;
        uv_down_right.y = uv_y + 1.0f / FONT_SIZE;
        
        Vector2 uv_down_left;
        uv_down_left.x = uv_x;
        uv_down_left.y = uv_y + 1.0f / FONT_SIZE;
    
        uvs.push_back( uv_up_left );
        uvs.push_back( uv_down_left );
        uvs.push_back( uv_up_right );
        
        uvs.push_back( uv_down_right );
        uvs.push_back( uv_up_right );
        uvs.push_back( uv_down_left );
    }
    
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glBufferData( GL_ARRAY_BUFFER, vertices.size() * sizeof( Vector2 ), &vertices[ 0 ], GL_STATIC_DRAW );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_uvBuffer );
    glBufferData( GL_ARRAY_BUFFER, uvs.size() * sizeof( Vector2 ), &uvs[ 0 ], GL_STATIC_DRAW );
    
    [ self bind ];
    
    [ m_texture bind ];
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