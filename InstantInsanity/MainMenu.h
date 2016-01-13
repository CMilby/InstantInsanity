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

@interface MainMenu : NSObject <UIGestureRecognizerDelegate> {
    GLKView *m_view;
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    Cube *m_cube1;
    Cube *m_cube2;
    Cube *m_cube3;
    Cube *m_cube4;
    
    Plane *m_gameTitle;
    Plane *m_playGame;
    Plane *m_howToPlay;
    
    Shader *m_standardShader;
    Shader *m_selectionShader;
    
    Camera *m_camera;
}

- ( id ) init: ( Camera* ) camera inView: ( GLKView* ) view;

- ( void ) update;

- ( void ) render;

@end

#endif /* MainMenu_h */
