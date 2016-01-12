//
//  Mesh.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Mesh.h"

@implementation Mesh {
    
}

- ( id ) init {
    if ( self = [ super init ] ) {
        // Need to implement
    }
    return self;
}

- ( id ) init: ( const GLfloat[] ) vertices withVertexSize: ( GLuint ) vertexSize withUVs: ( const GLfloat[] ) uvs withUVSize: ( GLuint ) uvSize withNormals: ( const GLfloat[] ) normals withNormalSize: ( GLuint ) normalSize {
    if ( self = [ super init ] ) {
        glGenBuffers( 1, &m_vertexBuffer );
        glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
        glBufferData( GL_ARRAY_BUFFER, vertexSize, vertices, GL_STATIC_DRAW );
        
        glGenBuffers( 1, &m_uvBuffer );
        glBindBuffer( GL_ARRAY_BUFFER, m_uvBuffer );
        glBufferData( GL_ARRAY_BUFFER, uvSize, uvs, GL_STATIC_DRAW );
        
        glGenBuffers( 1, &m_normalBuffer );
        glBindBuffer( GL_ARRAY_BUFFER, m_normalBuffer );
        glBufferData( GL_ARRAY_BUFFER, normalSize, normals, GL_STATIC_DRAW );
        
        m_size = vertexSize / sizeof( vertices[ 0 ] );
    }
    return self;
}

- ( void ) cleanup {
    if ( m_vertexBuffer ) {
        glDeleteBuffers( 1, &m_vertexBuffer );
        m_vertexBuffer = 0;
    }
    
    if ( m_uvBuffer ) {
        glDeleteBuffers( 1, &m_uvBuffer );
        m_uvBuffer = 0;
    }
    
    if ( m_normalBuffer ) {
        glDeleteBuffers( 1, &m_normalBuffer );
        m_normalBuffer = 0;
    }
}

- ( void ) render {
    glEnableVertexAttribArray( GLKVertexAttribPosition );
    glEnableVertexAttribArray( GLKVertexAttribTexCoord0 );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_vertexBuffer );
    glVertexAttribPointer( GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 0, ( GLvoid* ) 0 );
    
    glBindBuffer( GL_ARRAY_BUFFER, m_uvBuffer );
    glVertexAttribPointer( GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 0, ( GLvoid* ) 0 );
    
    glDrawArrays( GL_TRIANGLES, 0, m_size );
    
    glDisableVertexAttribArray( GLKVertexAttribTexCoord0 );
    glDisableVertexAttribArray( GLKVertexAttribPosition );
}

@end


















