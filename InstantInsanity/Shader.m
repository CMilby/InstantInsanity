//
//  Shader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Shader.h"

#include "Constants.h"
#include "RenderableEntity.h"

@implementation Shader {
    
}

- ( id ) init: ( NSString* ) vertexShader withFrag: ( NSString* ) fragmentShader {
    if ( self = [ super init ] ) {
        m_program = glCreateProgram();
        GLuint vertShader = [ self loadVertexShader: vertexShader ];
        GLuint fragShader = [ self loadFragmentShader: fragmentShader ];
        
        glAttachShader( m_program, vertShader );
        glAttachShader( m_program, fragShader );
        
        glBindAttribLocation( m_program, GLKVertexAttribPosition, "position" );
        glBindAttribLocation( m_program, GLKVertexAttribTexCoord0, "texCoord" );
        glBindAttribLocation( m_program, GLKVertexAttribNormal, "normal" );
        
        if ( ![ self linkShader: m_program ] ) {
            NSLog( @"Failed to link program" );
            
            if ( vertShader ) {
                glDeleteShader( vertShader );
                vertShader = 0;
            }
            
            if ( fragShader ) {
                glDeleteShader( fragShader );
                fragShader = 0;
            }
            
            if ( m_program ) {
                glDeleteProgram( m_program );
                m_program = 0;
            }
            
            exit( 1 );
        }
        
        if ( vertShader ) {
            glDetachShader( m_program, vertShader );
            glDeleteProgram( vertShader );
        }
        
        if ( fragShader ) {
            glDetachShader( m_program, fragShader );
            glDeleteProgram( fragShader );
        }
        
        m_uniformMap = [ [ NSMutableDictionary alloc ] init ];
    }
    return self;
}

- ( void ) cleanup {
    if ( m_program ) {
        glDeleteProgram( m_program );
        m_program = 0;
    }
}

- ( void ) updateEntity: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera {
    
}

- ( void ) updateString: ( NSString* ) text withX: ( int ) x withY: ( int ) y withSize: ( int ) size {
    
}

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withSize: ( int ) size {
    
}

- ( void ) addUniform:( NSString* ) name {
    GLint location = glGetUniformLocation( m_program, [ name cStringUsingEncoding:NSASCIIStringEncoding ] );
    if ( location == -1 ) {
        NSLog( @"Could not found uniform %@", name );
    }
    [ m_uniformMap setObject: [ NSNumber numberWithInt: location ] forKey: name ];
}

- ( void ) updateUniform: ( NSString* ) name withMatrix4: ( GLKMatrix4 ) matrix {
    glUniformMatrix4fv( [ [ m_uniformMap valueForKey: name ] intValue ], 1, GL_FALSE, &matrix.m[ 0 ] );
}

- ( void ) updateUniform: ( NSString* ) name withInt: ( GLint ) integer {
    glUniform1i( [ [ m_uniformMap valueForKey: name ] intValue ], integer );
}

- ( void ) updateUniform: ( NSString* ) name withFloat: ( GLfloat ) value {
    glUniform1f( [ [ m_uniformMap valueForKey: name ] intValue], value );
}

- ( GLuint ) loadFragmentShader: ( NSString* ) filename {
    NSString *path = [ [ NSBundle mainBundle ] pathForResource: filename ofType: @"fsh" ];
    GLuint fragShader;
    if ( ![ self compileShader: &fragShader withType: GL_FRAGMENT_SHADER withFile: path ] ) {
        NSLog( @"Failed to compile fragment shader" );
        exit( 1 );
    }
    return fragShader;
}

- ( GLuint ) loadVertexShader: ( NSString* ) filename {
    NSString *path = [ [ NSBundle mainBundle ] pathForResource: filename ofType: @"vsh" ];
    GLuint vertShader;
    if ( ![ self compileShader: &vertShader withType: GL_VERTEX_SHADER withFile: path ] ) {
        NSLog( @"Failed to compile vertex shader" );
        exit( 1 );
    }
    return vertShader;
}

- ( BOOL ) compileShader: ( GLuint* ) shader withType: ( GLenum ) type withFile: ( NSString* ) file {
    const GLchar *source = ( GLchar* ) [ [ NSString stringWithContentsOfFile: file encoding:NSUTF8StringEncoding error:nil ] UTF8String ];
    if ( !source ) {
        NSLog( @"Failed to load shader" );
        return false;
    }
    
    *shader = glCreateShader( type );
    glShaderSource( *shader, 1, &source, NULL );
    glCompileShader( *shader );
    
    if ( DEBUG_ENABLED ) {
        GLint logLength;
        glGetShaderiv( *shader, GL_INFO_LOG_LENGTH, &logLength );
        if ( logLength > 0 ) {
            GLchar *log = ( GLchar* ) malloc( logLength );
            glGetShaderInfoLog( *shader, logLength, &logLength, log );
            NSLog( @"Shader compile log:\n%s", log );
            free( log );
        }
    }
    
    GLint status;
    glGetShaderiv( *shader, GL_COMPILE_STATUS, &status );
    if ( status == 0 ) {
        glDeleteShader( *shader );
        return false;
    }
    return true;
}

- ( void ) bind {
    glUseProgram( m_program );
}

- ( BOOL ) linkShader: ( GLuint ) program {
    glLinkProgram( program );
    
    if ( DEBUG_ENABLED ) {
        GLint logLength;
        glGetProgramiv( program, GL_INFO_LOG_LENGTH, &logLength );
        if ( logLength > 0 ) {
            GLchar *log = ( GLchar* ) malloc( logLength );
            glGetProgramInfoLog( program, logLength, &logLength, log );
            NSLog( @"Program link log:\n%s", log );
            free( log );
        }
    }
    
    GLint status;
    glGetProgramiv( program, GL_LINK_STATUS, &status );
    if ( status == 0 ) {
        return false;
    }
    return true;
}

@end