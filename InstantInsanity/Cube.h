//
//  Cube.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CUBE_H__
#define __CUBE_H__

#include "RenderableEntity.h"

@interface Cube : RenderableEntity {
    
}

- ( id ) init: ( NSString* ) textureFile;

- ( GLKVector3 ) getMin;

- ( GLKVector3 ) getMax;

@end

#endif /* Cube_h */
