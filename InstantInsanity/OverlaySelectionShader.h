//
//  OverlaySelectionShader.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __OVERLAY_SELECTION_SHADER_H__
#define __OVERLAY_SELECTION_SHADER_H__

#include "Shader.h"

@interface OverlaySelectionShader : Shader {
    
}

- ( id ) init;

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withWidth: ( int ) width withHeight: ( int ) height;

@end

#endif /* OverlaySelectionShader_h */
