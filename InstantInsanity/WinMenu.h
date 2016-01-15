//
//  WinMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __WIN_MENU_H__
#define __WIN_MENU_H__

#include "Scene.h"

@class GameScene;

@interface WinMenu : Scene {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    GameScene *m_parent;
    
    Texture *m_winTexture;
    Texture *m_mainMenuButton;
    Texture *m_playAgainButton;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

- ( void ) setTexture: ( Texture* ) texture;

@end

#endif /* WinMenu_h */
