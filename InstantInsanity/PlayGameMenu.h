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
    
    Texture *m_gameTitle;
    Texture *m_classic1;
    Texture *m_classic2;
    Texture *m_5Cube;
    Texture *m_6Cube;
    Texture *m_2x2x1;
    Texture *m_clocks;
    
    Texture *m_howToPlayClassicOne;
    Texture *m_howToPlayClassicTwo;
    Texture *m_howToPlayFive;
    Texture *m_howToPlaySix;
    Texture *m_howToPlaySquare;
    Texture *m_howToPlayClocks;
    
    Texture *m_htp;
}
- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* PlayGameMenu_h */
