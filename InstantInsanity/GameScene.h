//
//  GameScene.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __GAME_SCENE_H__
#define __GAME_SCENE_H__

#include "Cube.h"
#include "Scene.h"
#include "Stopwatch.h"
#include "TextShader.h"

@interface GameScene : Scene <UIGestureRecognizerDelegate> {
    UITapGestureRecognizer *m_tapGestureRecognizer;
    UIPanGestureRecognizer *m_panGestureRecognizer;
    UIPinchGestureRecognizer *m_pinchGestureRecognizer;
    
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeft;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRight;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerUp;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerDown;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerLeftTwo;
    UISwipeGestureRecognizer *m_swipeGestureRecognizerRightTwo;
    
    NSMutableArray<Cube*> *m_cubes;
    
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

- ( void ) setCubes: ( NSMutableArray<Cube*>* ) cubes;

- ( NSMutableArray<RenderableEntity*>* ) getPickedRender;

- ( bool ) hasWon;

@end

#endif /* GameScene_h */







