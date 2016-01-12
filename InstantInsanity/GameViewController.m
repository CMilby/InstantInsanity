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
#include "Ray.h"

@interface GameViewController () {
    Camera *m_camera;
    Game *m_game;
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
    
    m_camera = [ [ Camera alloc ] init: GLKVector3Make( 0.0f, 0.0f, 0.0f ) ];
    [ m_camera setup: -50.0f yAngle: -20.0f distance: 25.0f ];
    
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
    
    [ m_game cleanup ];
}

- ( BOOL ) prefersStatusBarHidden {
    return YES;
}

- ( void ) setupGL {
    [ EAGLContext setCurrentContext:self.context ];
    
    glClearColor( 0.65f, 0.65f, 0.65f, 1.0f );
    glEnable( GL_CULL_FACE );
    glCullFace( GL_BACK );
    glEnable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    m_game = [ [ Game alloc ] init: m_camera inView: ( GLKView* ) self.view ];
}

- ( void ) tearDownGL {
    [ EAGLContext setCurrentContext:self.context ];
    
    [ m_game cleanup ];
}

- ( void ) update {
    [ m_camera updateView ];
    [ m_game update ];
}

- ( void ) glkView: ( GLKView* ) view drawInRect: ( CGRect ) rect {
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    [ m_game render ];
}

@end
