//
//  Scene.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __SCENE_H__
#define __SCENE_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Camera.h"
#include "Shader.h"

extern int CurrentScene;

typedef enum MyScenes {
    SCENE_MAIN_MENU,
    SCENE_PLAY_GAME_MENU,
    SCENE_CLASSIC_1_GAME,
    SCENE_CLASSIC_2_GAME,
    SCENE_FIVE_CUBE_GAME,
    SCENE_SIX_CUBE_GAME,
    SCENE_SQUARE_GAME,
    SCENE_CLOCKS_GAME,
    NUMBER_SCENES
} SCENES;

@interface Scene : NSObject {
    GLKView *m_view;
    GLKMatrix4 m_orthMatrix;
    
    NSMutableArray<Shader*> *m_shaders;
    Camera *m_camera;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* Scene_h */
