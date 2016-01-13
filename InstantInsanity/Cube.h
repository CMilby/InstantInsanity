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
    int m_frontColor;
    int m_backColor;
    int m_leftColor;
    int m_rightColor;
    int m_topColor;
    int m_bottomColor;
}

- ( id ) init: ( NSString* ) textureFile;

- ( int ) frontColor;

- ( int ) backColor;

- ( int ) leftColor;

- ( int ) rightColor;

- ( int ) topColor;

- ( int ) bottomColor;

- ( int ) color: ( int ) index;

- ( void ) setFrontColor: ( int ) color;

- ( void ) setBackColor: ( int ) color;

- ( void ) setLeftColor: ( int ) color;

- ( void ) setRightColor: ( int ) color;

- ( void ) setTopColor: ( int ) color;

- ( void ) setBottomColor: ( int ) color;

- ( void ) rotateX: ( bool ) clockwise;

- ( void ) rotateY: ( bool ) clockwise;

- ( void ) rotateZ: ( bool ) clockwise;

@end

#endif /* Cube_h */
