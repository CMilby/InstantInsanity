//
//  QuitMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __QUIT_MENU_H__
#define __QUIT_MENU_H__

#include "Plane.h"
#include "Scene.h"

@interface QuitMenu : Scene {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    
    Plane *m_quitMenu;
    Plane *m_yesButton;
    Plane *m_noButton;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* QuitMenu_h */
