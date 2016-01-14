//
//  PlayGameMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __PLAY_GAME_MENU_H__
#define __PLAY_GAME_MENU_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Cube.h"
#include "Plane.h"
#include "Scene.h"

@interface PlayGameMenu : Scene {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    Cube *m_cube1;
    Cube *m_cube2;
    Cube *m_cube3;
    Cube *m_cube4;
    
    GLKMatrix4 m_orthProjection;
    
    Plane *m_gameTitle;
    Plane *m_classic1;
    Plane *m_classic2;
    Plane *m_5Cube;
    Plane *m_6Cube;
    Plane *m_2x2x1;
    Plane *m_clocks;
}
- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* PlayGameMenu_h */
