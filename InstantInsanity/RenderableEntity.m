//
//  RenderableEntity.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "RenderableEntity.h"

@implementation RenderableEntity {
    
}

- ( id ) init: ( Mesh* ) mesh withTexture: ( Texture* ) texture withTransform: ( Transform* ) transform {
    if ( self = [ super init: transform ] ) {
        m_mesh = mesh;
        m_texture = texture;
    }
    return self;
}

- ( void ) cleanup {
    [ m_mesh cleanup ];
    [ m_texture cleanup ];
}

- ( void ) update {
    
}

- ( void ) render {
    [ m_mesh render ];
}

- ( void ) bind {
    [ m_texture bind ];
}

- ( int ) getCode {
    return [ m_texture getCode ];
}

- ( void ) setCode: ( int ) code {
    [ m_texture setCode: code ];
}

@end