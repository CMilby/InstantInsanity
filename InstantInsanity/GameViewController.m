//
//  GameViewController.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#import "GameViewController.h"

#import <OpenGLES/ES2/glext.h>

#include "ClassicOneGameScene.h"
#include "ClassicTwoGameScene.h"
#include "ClocksGameScene.h"
#include "FiveCubeGameScene.h"
#include "MainMenu.h"
#include "OverlayShader.h"
#include "OverlaySelectionShader.h"
#include "PlayGameMenu.h"
#include "SelectionShader.h"
#include "SixCubeGameScene.h"
#include "SquareGameScene.h"
#include "StandardShader.h"
#include "TextShader.h"

@interface GameViewController () {
    ADBannerView *m_adView;
    
    Camera *m_camera;
    
    NSMutableArray<Shader*> *m_shaders;
    Shader *m_standardShader;
    Shader *m_selectionShader;
    Shader *m_textShader;
    Shader *m_overlayShader;
    Shader *m_selectionOverlayShader;
    
    NSMutableArray<Scene*> *m_scenes;
    int m_lastScene;
    
    Scene *m_mainMenu;
    Scene *m_playGameMenu;

    Scene *m_classic1GameScene;
    Scene *m_classic2GameScene;
    Scene *m_fiveCubeScene;
    Scene *m_sixCubeScene;
    Scene *m_squareScene;
    Scene *m_clocksScene;
    
    // Music From:
    // http://www.freesound.org/people/Setuniman/sounds/332778/
    // Under Creative Commons License
    // http://creativecommons.org/licenses/by-nc/3.0/
    AVAudioPlayer *m_music;
}

@property ( strong, nonatomic ) EAGLContext *context;

@end

@implementation GameViewController {
    
}

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
    
    m_adView = [ [ ADBannerView alloc ] initWithFrame: CGRectZero ];
    [ self.view addSubview: m_adView ];
    
    [ self setupGL ];
}

- ( void ) dealloc {
    [ self tearDownGL ];
    
    if ( [ EAGLContext currentContext ] == self.context ) {
        [ EAGLContext setCurrentContext: nil ];
    }
    
    for ( int i = 0; i < [ m_scenes count ]; i++ ) {
        [ m_scenes[ i ] cleanup ];
    }
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
    
    glClearColor( 0.85f, 0.85f, 0.85f, 1.0f );
    
    glEnable( GL_DEPTH_TEST );
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    m_shaders = [ [ NSMutableArray alloc ] initWithCapacity: NUMBER_SHADERS ];
    m_standardShader = [ [ StandardShader alloc ] init ];
    m_selectionShader = [ [ SelectionShader alloc ] init ];
    m_textShader = [ [ TextShader alloc ] init: @"Courier_New" ];
    m_overlayShader = [ [ OverlayShader alloc ] init ];
    m_selectionOverlayShader = [ [ OverlaySelectionShader alloc ] init ];
    
    [ m_shaders addObject: m_standardShader ];
    [ m_shaders addObject: m_selectionShader ];
    [ m_shaders addObject: m_textShader ];
    [ m_shaders addObject: m_overlayShader ];
    [ m_shaders addObject: m_selectionOverlayShader ];
    
    m_camera = [ [ Camera alloc ] init: GLKVector3Make( 0.0f, 0.0f, 0.0f ) ];
    [ m_camera setup: -45.0f yAngle: 0.0f distance: 10.0f ];
    
    GLKView *glView = ( GLKView* ) self.view;
    m_scenes = [ [ NSMutableArray alloc ] initWithCapacity: NUMBER_SCENES ];
    m_mainMenu = [ [ MainMenu alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_playGameMenu = [ [ PlayGameMenu alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    
    m_classic1GameScene = [ [ ClassicOneGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_classic2GameScene = [ [ ClassicTwoGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_fiveCubeScene = [ [ FiveCubeGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_sixCubeScene = [ [ SixCubeGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_squareScene = [ [ SquareGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    m_clocksScene = [ [ ClocksGameScene alloc ] initWithView: glView withShaders: m_shaders withCamera: m_camera ];
    
    [ m_scenes addObject: m_mainMenu ];
    [ m_scenes addObject: m_playGameMenu ];
    [ m_scenes addObject: m_classic1GameScene ];
    [ m_scenes addObject: m_classic2GameScene ];
    [ m_scenes addObject: m_fiveCubeScene ];
    [ m_scenes addObject: m_sixCubeScene ];
    [ m_scenes addObject: m_squareScene ];
    [ m_scenes addObject: m_clocksScene ];
    
    NSString *filePath = [ [ NSBundle mainBundle ] pathForResource: @"BackgroundMusic" ofType: @"mp3" ];
    NSURL *url = [ NSURL fileURLWithPath: filePath ];
    m_music = [ [ AVAudioPlayer alloc ] initWithContentsOfURL: url error:nil ];
    m_music.numberOfLoops = -1;
    [ m_music play ];
    
    [ m_scenes[ CurrentScene ] receivedFocus ];
    m_lastScene = CurrentScene;
}

- ( void ) tearDownGL {
    [ EAGLContext setCurrentContext: self.context ];
}

- ( void ) update {
    if ( m_lastScene != CurrentScene ) {
        if ( m_lastScene != -1 ) {
            [ m_scenes[ m_lastScene ] lostFocus ];
        }
    
        [ m_scenes[ CurrentScene ] receivedFocus ];
        m_lastScene = CurrentScene;
        [ m_camera setup: -45.0f yAngle: 0.0f distance: 10.0f ];
    }
    
    [ m_camera updateView ];
    [ m_scenes[ CurrentScene ] update ];
}

- ( void ) glkView: ( GLKView* ) view drawInRect: ( CGRect ) rect {
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );
    
    [ m_scenes[ CurrentScene ] render ];
}

- ( bool ) bannerViewActionShouldBegin: ( ADBannerView* ) banner willLeaveApplication: ( BOOL ) willLeave {
    return true;
}

- ( void ) bannerView: ( ADBannerView* ) banner didFailToReceiveAdWithError: ( NSError* ) error {
    [ self layoutAnimated: true ];
}

- ( void ) bannerViewDidLoadAd: ( ADBannerView* ) banner {
    [ self layoutAnimated: true ];
}

- ( void ) layoutAnimated: ( bool ) animated {
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = m_adView.frame;
    
    if ( m_adView.bannerLoaded ) {
        contentFrame.size.height -= bannerFrame.size.height;
        bannerFrame.origin.y = contentFrame.size.height;
    } else {
        bannerFrame.origin.y = contentFrame.size.height;
    }
    
    [ UIView animateWithDuration: animated ? 0.25 : 0.0 animations: ^{
        self.view.frame = contentFrame;
        [ self.view layoutIfNeeded ];
        m_adView.frame = bannerFrame;
    }];
}

@end











