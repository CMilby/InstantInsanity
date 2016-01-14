//
//  HowToPlayMenu.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __HOW_TO_PLAY_MENU_H__
#define __HOW_TO_PLAY_MENU_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Scene.h"

@interface HowToPlayMenu : Scene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

@end

#endif /* HowToPlayMenu_h */
