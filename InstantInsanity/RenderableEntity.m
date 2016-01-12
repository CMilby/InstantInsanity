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

- ( void ) render: ( Shader* ) shader withCamera: ( Camera* ) camera {
    [ shader bind ];
    
    [ m_texture bind ];
    [ shader updateUniform: @"sampler" withInt: 0 ];
    
    GLKMatrix4 mvp = GLKMatrix4Multiply( GLKMatrix4Multiply( [ m_transform getProjectionMatrix ], [ camera getViewMatrix ] ), [ m_transform getModelMatrix ] );
    [ shader updateUniform: @"mvp" withMatrix4: mvp ];
    bool isPicked = [ self isPicked ];
    if ( isPicked ) {
        [ shader updateUniform: @"transparent" withInt: 1 ];
    } else {
        [ shader updateUniform: @"transparent" withInt: 0 ];
    }
    
    [ m_mesh render ];
}

- ( void ) bind {
    [ m_texture bind ];
}

- ( int ) getCode {
    return m_code;
}

- ( void ) setCode: ( int ) code {
    m_code = code;
}

@end