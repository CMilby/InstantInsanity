//
//  SelectionShader.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "SelectionShader.h"

#include "RenderableEntity.h"

@implementation SelectionShader {
    
}

- ( id ) init {
    if ( self = [ super init: @"SelectionShader" withFrag: @"SelectionShader" ] ) {
        [ self addUniform: @"mvp" ];
        [ self addUniform: @"code" ];
    }
    return self;
}

- ( void ) update: ( RenderableEntity* ) entity withProjection: ( GLKMatrix4 ) projection withCamera: ( Camera* ) camera {
    [ self bind ];
    
    GLKMatrix4 mvp = GLKMatrix4Multiply( GLKMatrix4Multiply( projection, [ camera getViewMatrix ] ), [ [ entity transform ] getModelMatrix ] );
    [ self updateUniform: @"mvp" withMatrix4: mvp ];
    [ self updateUniform: @"code" withFloat: [ entity getCode ] ];
    
    [ entity render: self withCamera: camera ];
}

@end