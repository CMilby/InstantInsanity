//
//  Game.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __GAME_H__
#define __GAME_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

#include "Cube.h"
#include "Scene.h"
#include "Stopwatch.h"
#include "TextShader.h"

@interface Game : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    UIPanGestureRecognizer *m_panGestureRecognizer;
    UIPinchGestureRecognizer *m_pinchGestureRecognizer;
    
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeft;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRight;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerUp;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerDown;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeftTwo;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRightTwo;
    
    Cube *m_cube1;
    Cube *m_cube2;
    Cube *m_cube3;
    Cube *m_cube4;
    
    Cube *m_pickedCube;
    bool m_picked;
    
    int m_rotateX;
    int m_rotateY;
    int m_rotateZ;
    
    bool m_shouldRotateX;
    bool m_shouldRotateY;
    bool m_shouldRotateZ;

    int m_totalRotation;
    
    TextShader *m_textShader;
    Stopwatch *m_stopwatch;
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

- ( void ) receivedFocus;

- ( void ) lostFocus;

@end

#endif /* Game_h */
