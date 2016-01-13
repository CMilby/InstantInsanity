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

#include "Camera.h"
#include "Cube.h"
#include "Shader.h"
#include "Stopwatch.h"
#include "TextShader.h"

@interface Game : NSObject <UIGestureRecognizerDelegate> {
    bool m_picked;
    
    GLKView *m_view;
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
    int m_rotateX;
    int m_rotateY;
    int m_rotateZ;
    
    bool m_shouldRotateX;
    bool m_shouldRotateY;
    bool m_shouldRotateZ;

    int m_totalRotation;
    
    Shader *m_shader;
    Shader *m_selectionShader;
    TextShader *m_textShader;
    
    Camera *m_camera;
    Stopwatch *m_stopwatch;
}

- ( id ) init: ( Camera* ) mainCamera inView: ( GLKView* ) view;

- ( void ) cleanup;

- ( void ) update;

- ( void ) render;

@end

#endif /* Game_h */
