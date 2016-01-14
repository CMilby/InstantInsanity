//
//  SelectionShader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __SELECTION_SHADER_H__
#define __SELECTION_SHADER_H__

#include "Shader.h"

@interface SelectionShader : Shader {
    
}

- ( id ) init;

- ( void ) updateEntity: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera;
    
@end

#endif /* SelectionShader_h */
