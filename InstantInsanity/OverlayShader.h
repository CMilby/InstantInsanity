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
   
}

- ( id ) init;

- ( void ) cleanup;

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withWidth: ( int ) width withHeight: ( int ) height;

@end

#endif /* OverlayShader_h */
