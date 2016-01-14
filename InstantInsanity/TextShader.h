//
//  TextShader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/12/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __TEXT_SHADER_H__
#define __TEXT_SHADER_H__

#include "Shader.h"
#include "Texture.h"

@interface TextShader : Shader {
    GLuint m_vertexBuffer;
    GLuint m_uvBuffer;
    
    Texture *m_texture;
}

- ( void ) cleanup;

- ( id ) init: ( NSString* ) textureFile;

- ( void ) updateString: ( NSString* ) text withX: ( int ) x withY: ( int ) y withSize: ( int ) size;

@end

#endif /* TextShader_h */
