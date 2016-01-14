//
//  StandardShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "StandardShader.h"

#include "RenderableEntity.h"

@implementation StandardShader {
    
}

- ( id ) init {
    if ( self = [ super init: @"StandardShader" withFrag: @"StandardShader" ] ) {
        [ self addUniform: @"sampler" ];
        [ self addUniform: @"mvp" ];
        [ self addUniform: @"transparent" ];
    }
    return self;
}

- ( void ) updateEntity: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera {
    [ self bind ];
    
    [ entity bind ];
    [ self updateUniform: @"sampler" withInt: 0 ];
    
    GLKMatrix4 mvp = GLKMatrix4Multiply( GLKMatrix4Multiply( projection, [ camera getViewMatrix ] ), [ [ entity transform ] getModelMatrix ] );
    [ self updateUniform: @"mvp" withMatrix4: mvp ];
    [ self updateUniform: @"transparent" withInt: [ entity isPicked ] ? 1 : 0 ];
    
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    [ entity render ];
    
    glDisable( GL_BLEND );
}

@end