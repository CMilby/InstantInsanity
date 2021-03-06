//
//  FiveCubeGameScene.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __FIVE_CUBE_GAME_SCENE_H__
#define __FIVE_CUBE_GAME_SCENE_H__

#include "GameScene.h"

@interface FiveCubeGameScene : GameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( bool ) hasWon;

@end

#endif /* FiveCubeGameScene_h */
