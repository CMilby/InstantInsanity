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

#include "Camera.h"
#include "Texture.h"

@class RenderableEntity;

typedef enum MyShaders {
    SHADER_STANDARD,
    SHADER_SELECTION,
    SHADER_TEXT,
    SHADER_OVERLAY,
    SHADER_SELECTION_OVERLAY,
    NUMBER_SHADERS
} Shaders;

@interface Shader : NSObject {
    NSMutableDictionary *m_uniformMap;
    GLuint m_program;
    
    GLuint m_vertexBuffer;
    GLuint m_uvBuffer;
}

- ( id ) init: ( NSString* ) vertexShader withFrag: ( NSString* ) fragmentShader;

- ( void ) cleanup;

- ( void ) updateEntity: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera;

- ( void ) updateString: ( NSString* ) text withX: ( int ) x withY: ( int ) y withSize: ( int ) size;

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withSize: ( int ) size;

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withWidth: ( int ) width withHeight: ( int ) height;

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
