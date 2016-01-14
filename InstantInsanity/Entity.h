//
//  Entity.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __ENTITY_H__
#define __ENTITY_H__

#import <Foundation/Foundation.h>

#include "Shader.h"
#include "Transform.h"

@class Camera;

@interface Entity : NSObject {
    NSMutableArray<Entity*> *m_children;
    
    Transform *m_transform;
    bool m_isPicked;
}

- ( id ) init;

- ( id ) init: ( Transform* ) transform;

- ( void ) cleanup;

- ( void ) cleanupAll;

- ( Entity* ) addChild: ( Entity* ) child;

- ( void ) update;

- ( void ) updateAll;

- ( void ) render;

- ( void ) renderAll;

- ( Transform* ) transform;

- ( void ) setTransform: ( Transform* ) transform;

- ( bool ) isPicked;

- ( void ) setIsPicked: ( bool ) value;

@end

#endif /* Entity_h */
