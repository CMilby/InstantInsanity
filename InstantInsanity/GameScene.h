//
//  GameScene.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __GAME_SCENE_H__
#define __GAME_SCENE_H__

#include "Cube.h"
#include "PauseMenu.h"
#include "QuitMenu.h"
#include "Scene.h"
#include "Stopwatch.h"
#include "TextShader.h"
#include "WinMenu.h"

typedef enum MyMenus {
    MENU_NONE = -1,
    MENU_PAUSE = 0,
    MENU_QUIT = 1,
    MENU_WIN = 2,
    NUMBER_MENUS = 3
} Menus;

@interface GameScene : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    UIPanGestureRecognizer *m_panGestureRecognizer;
    UIPinchGestureRecognizer *m_pinchGestureRecognizer;
    
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeft;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRight;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerUp;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerDown;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeftTwo;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRightTwo;
    
    NSMutableArray<Cube*> *m_cubes;
    
    Cube *m_pickedCube;
    bool m_picked;
    
    int m_rotateX;
    int m_rotateY;
    int m_rotateZ;
    
    bool m_shouldRotateX;
    bool m_shouldRotateY;
    bool m_shouldRotateZ;
    
    int m_totalRotation;
    
    Stopwatch *m_stopwatch;
    
    Texture *m_pauseButton;
    
    int m_currentMenu;
    NSMutableArray<Scene*> *m_menus;
    WinMenu *m_winMenu;
    PauseMenu *m_pauseMenu;
    QuitMenu *m_quitMenu;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) reset;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

- ( void ) setCubes: ( NSMutableArray<Cube*>* ) cubes;

- ( NSMutableArray<RenderableEntity*>* ) getPickedRender;

- ( bool ) hasWon;

- ( void ) setCurrentMenu: ( int ) currentMenu;

@end

#endif /* GameScene_h */







