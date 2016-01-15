//
//  WinMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "WinMenu.h"

#include "GameScene.h"

@implementation WinMenu {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_parent = parent;
    }
    return self;
}

@end