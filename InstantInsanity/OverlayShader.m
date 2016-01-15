//
//  OverlayShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "OverlayShader.h"

@implementation OverlayShader {
    
}

- ( id ) init {
    if ( self = [ super init: @"OverlayShader" withFrag: @"OverlayShader" ] ) {
        [ self addUniform: @"sampler" ];
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
}

- ( void ) updateTexture: ( Texture* ) texture withX: ( int ) x withY: ( int ) y withWidth: ( int ) width withHeight: ( int ) height {
    [ super updateTexture: texture withX: x withY: y withWidth: width withHeight: height ];
}

@end











