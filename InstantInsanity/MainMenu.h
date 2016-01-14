//
//  MainMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __MAIN_MENU_H__
#define __MAIN_MENU_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Cube.h"
#include "Plane.h"
#include "Scene.h"

@interface MainMenu : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    GLKMatrix4 m_orthMatrix;
    
    Cube *m_cube1;
    Cube *m_cube2;
    Cube *m_cube3;
    Cube *m_cube4;
    
    Plane *m_gameTitle;
    Plane *m_playGame;
    Plane *m_howToPlay;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* MainMenu_h */
