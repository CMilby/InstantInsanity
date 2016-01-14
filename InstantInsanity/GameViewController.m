//
//  GameViewController.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "GameViewController.h"
#import <OpenGLES/ES2/glext.h>

#include "Game.h"
#include "MainMenu.h"
#include "PlayGameMenu.h"
#include "Scene.h"
#include "SelectionShader.h"
#include "StandardShader.h"

@interface GameViewController () {
    Camera *m_camera;
    
    NSMutableArray<Shader*> *m_shaders;
    Shader *m_standardShader;
    Shader *m_selectionShader;
    
    NSMutableArray<Scene*> *m_scenes;
    int m_lastScene;
    
    Scene *m_game;
    Scene *m_mainMenu;
    Scene *m_playGameMenu;
    
}

@property (strong, nonatomic) EAGLContext *context;

@end

@implementation GameViewController

- ( void ) viewDidLoad {
    [ super viewDidLoad ];
    
    self.context = [ [ EAGLContext alloc ] initWithAPI:kEAGLRenderingAPIOpenGLES2 ];
    
    if ( !self.context ) {
        NSLog( @"Failed to create ES context" );
    }
    
    GLKView *view = ( GLKView* ) self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.multipleTouchEnabled = true;
    
    [ self setupGL ];
}

- ( void ) dealloc {
    [ self tearDownGL ];
    
    if ( [ EAGLContext currentContext ] == self.context ) {
        [ EAGLContext setCurrentContext: nil ];
    }
    
    [ m_game cleanup ];
}

- ( void ) didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ];
    
    if ( [ self isViewLoaded ] && ( [ [ self view ] window ] == nil ) ) {
        self.view = nil;
        
        [ self tearDownGL ];
        
        if ( [ EAGLContext currentContext] == self.context ) {
            [ EAGLContext setCurrentContext:nil ];
        }
        self.context = nil;
    }
}

- ( BOOL ) prefersStatusBarHidden {
    return YES;
}

- ( void ) setupGL {
    [ EAGLContext setCurrentContext:self.context ];
    
    glClearColor( 0.65f, 0.65f, 0.65f, 1.0f );
    
    // glEnable( GL_CULL_FACE );
    // glCullFace( GL_BACK );
    glEnable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    m_shaders = [ [ NSMutableArray alloc ] initWithCapacity: 2 ];
    m_standardShader = [ [ StandardShader alloc ] init ];
    m_selectionShader = [ [ SelectionShader alloc ] init ];
    [ m_shaders addObject: m_standardShader ];
    [ m_shaders addObject: m_selectionShader ];
    
    m_camera = [ [ Camera alloc ] init: GLKVector3Make( 0.0f, 0.0f, 0.0f ) ];
    [ m_camera setup: -45.0f yAngle: 0.0f distance: 10.0f ];
    
    m_scenes = [ [ NSMutableArray alloc ] init ];
    m_mainMenu = [ [ MainMenu alloc ] initWithView: ( GLKView* ) self.view withShaders: m_shaders withCamera: m_camera ];
    m_playGameMenu = [ [ PlayGameMenu alloc ] initWithView: ( GLKView* ) self.view withShaders: m_shaders withCamera: m_camera ];
    m_game = [ [ Game alloc ] initWithView: ( GLKView* ) self.view withShaders: m_shaders withCamera: m_camera ];
    
    [ m_scenes addObject: m_mainMenu ];
    [ m_scenes addObject: m_playGameMenu ];
    [ m_scenes addObject: m_game ];
    
    [ m_scenes[ CurrentScene ] receivedFocus ];
    m_lastScene = CurrentScene;
}

- ( void ) tearDownGL {
    [ EAGLContext setCurrentContext: self.context ];
}

- ( void ) update {
    if ( m_lastScene != CurrentScene ) {
        [ m_scenes[ m_lastScene ] lostFocus ];
        [ m_scenes[ CurrentScene ] receivedFocus ];
        m_lastScene = CurrentScene;
    }
    
    [ m_camera updateView ];
    
    [ m_scenes[ CurrentScene ] update ];
}

- ( void ) glkView: ( GLKView* ) view drawInRect: ( CGRect ) rect {
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    [ m_scenes[ CurrentScene ] render ];
}

@end
