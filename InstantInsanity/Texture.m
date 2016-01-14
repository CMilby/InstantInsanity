//
//  Texture.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Texture.h"

@implementation Texture {
    
}

- ( id ) init: ( NSString* ) filename {
    if ( self = [ super init ] ) {
        CGImageRef spriteImage = [ UIImage imageNamed: filename ].CGImage;
        if ( !spriteImage ) {
            NSLog( @"Failed to load image %@", filename );
            exit( 1 );
        }
        
        size_t width = CGImageGetWidth( spriteImage );
        size_t height = CGImageGetHeight( spriteImage );
        
        GLubyte *spriteData = ( GLubyte* ) calloc( width * height * 4, sizeof( GLubyte ) );
        CGContextRef spriteContext = CGBitmapContextCreate( spriteData, width, height, 8, 4 * width, CGImageGetColorSpace( spriteImage ), kCGImageAlphaPremultipliedLast );
        
        CGContextDrawImage( spriteContext, CGRectMake( 0, 0, width, height ), spriteImage );
        CGContextRelease( spriteContext );
        
        glGenTextures( 1, &m_texture );
        glBindTexture( GL_TEXTURE_2D, m_texture );
        
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST );
        glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST );
        
        glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, ( GLuint ) width, ( GLuint ) height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData );
        
        free( spriteData );
    }
    return self;
}

- ( void ) cleanup {
    glDeleteTextures( 1, &m_texture );
}

- ( void ) bind {
    glActiveTexture( GL_TEXTURE0 );
    glBindTexture( GL_TEXTURE_2D, m_texture );
}

- ( void ) setCode: ( int ) code {
    m_code = code;
}

- ( int ) getCode {
    return m_code;
}

@end