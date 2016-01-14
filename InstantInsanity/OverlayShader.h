//
//  OverlayShader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __OVERLAY_SHADER_H__
#define __OVERLAY_SHADER_H__

#include "Shader.h"

@interface OverlayShader : Shader {
    GLuint m_vertexBuffer;
    GLuint m_uvBuffer;
}

- ( id ) init;

- ( void ) cleanup;

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withSize: ( int ) size;

@end

#endif /* OverlayShader_h */
