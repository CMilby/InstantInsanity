//
//  QuitMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __QUIT_MENU_H__
#define __QUIT_MENU_H__

#include "Scene.h"

@class GameScene;

@interface QuitMenu : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    GameScene *m_parent;
    
    Texture *m_quitMenu;
    Texture *m_yesButton;
    Texture *m_noButton;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* QuitMenu_h */
