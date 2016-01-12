//
//  Shader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __SHADER_H__
#define __SHADER_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@interface Shader : NSObject {
    NSMutableDictionary *m_uniformMap;
    GLuint m_program;
}

- ( id ) init: ( NSString* ) vertexShader withFrag: ( NSString* ) fragmentShader;

- ( void ) cleanup;

- ( GLuint ) loadVertexShader: ( NSString* ) filename;

- ( GLuint ) loadFragmentShader: ( NSString* ) filename;

- ( BOOL ) compileShader: ( GLuint* ) shader withType: ( GLenum ) type withFile: ( NSString* ) file;

- ( BOOL ) linkShader: ( GLuint ) program;

- ( void ) bind;

- ( void ) addUniform: ( NSString* ) name;

- ( void ) updateUniform: ( NSString* ) name withMatrix4: ( GLKMatrix4 ) matrix;

- ( void ) updateUniform: ( NSString* ) name withInt: ( GLint ) integer;

- ( void ) updateUniform: ( NSString* ) name withFloat: ( GLfloat ) value;

@end

#endif /* Shader_h */
