//
//  PauseMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __PAUSE_MENU_H__
#define __PAUSE_MENU_H__

#include "Scene.h"

@class GameScene;

@interface PauseMenu : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    GameScene *m_parent;

    Texture *m_pauseMenu;
    Texture *m_mainMenuButton;
    Texture *m_resumeButton;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* PauseMenu_h */
