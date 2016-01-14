//
//  ClassicTwoGameScene.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __CLASSIC_TWO_GAME_SCENE_H__
#define __CLASSIC_TWO_GAME_SCENE_H__

#include "GameScene.h"

@interface ClassicTwoGameScene : GameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( bool ) hasWon;

@end

#endif /* ClassicTwoGameScene_h */
