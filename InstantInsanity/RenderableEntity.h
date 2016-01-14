//
//  RenderableEntity.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __RENDERABLE_ENTITY_H__
#define __RENDERABLE_ENTITY_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Camera.h"
#include "Entity.h"
#include "Mesh.h"
#include "Texture.h"

@interface RenderableEntity : Entity {
    Mesh *m_mesh;
    Texture *m_texture;
}

- ( id ) init: ( Mesh* ) mesh withTexture: ( Texture* ) texture withTransform: ( Transform* ) transform;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) bind;

- ( int ) getCode;

- ( void ) setCode: ( int ) code;

@end

#endif /* RenderableEntity_h */
