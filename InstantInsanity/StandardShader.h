//
//  StandardShader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __STANDARD_SHADER_H__
#define __STANDARD_SHADER_H__

#include "Shader.h"

@interface StandardShader : Shader {
    
}

- ( id ) init;

- ( void ) update: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera;

@end

#endif /* StandardShader_h */
