//
//  Scene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Scene.h"

int CurrentScene = 0;

@implementation Scene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super init ] ) {
        m_view = view;
        m_shaders = shaders;
        m_camera = camera;
        
        CGFloat width = [ UIScreen mainScreen ].bounds.size.width;
        CGFloat height = [ UIScreen mainScreen ].bounds.size.height;
        
        m_orthMatrix = GLKMatrix4MakePerspective( GLKMathDegreesToRadians( 70.0f ), width / height, 0.1f, 100.0f );
    }
    return self;
}

- ( void ) cleanup {
    for ( int i = 0; i < [ m_shaders count ]; i++ ) {
        [ m_shaders[ i ] cleanup ];
    }
}

- ( void ) update {
    
}

- ( void ) render {
    
}

- ( void ) receivedFocus {
    
}

- ( void ) lostFocus {
    
}

@end