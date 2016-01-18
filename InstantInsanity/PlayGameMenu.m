//
//  PlayGameMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "PlayGameMenu.h"

#include "GameViewController.h"

@implementation PlayGameMenu {
    
}
- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        
        m_cube1 = [ [ Cube alloc ] init: @"Classic_Cube_1" ];
        [ [ m_cube1 transform ] setPosition: GLKVector3Make( 0.0, -4.5f, 0.0 ) ];
        m_cube2 = [ [ Cube alloc ] init: @"Classic_Cube_2" ];
        [ [ m_cube2 transform ] setPosition: GLKVector3Make( 0.0, -1.5f, 0.0 ) ];
        m_cube3 = [ [ Cube alloc ] init: @"Classic_Cube_3" ];
        [ [ m_cube3 transform ] setPosition: GLKVector3Make( 0.0, 1.5f, 0.0 ) ];
        m_cube4 = [ [ Cube alloc ] init: @"Classic_Cube_4" ];
        [ [ m_cube4 transform ] setPosition: GLKVector3Make( 0.0, 4.5f, 0.0 ) ];
        
        /*m_gameTitle = [ [ Plane alloc ] init: @"GameTitle" ];
        [ [ m_gameTitle transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_gameTitle transform ] setPosition: GLKVector3Make( -1.0f, 4.5f, 1.0f ) ];
        [ [ m_gameTitle transform ] setScale: GLKVector3Make( 4.0f, 1.0f, 0.85f ) ];
        
        m_classic1 = [ [ Plane alloc ] init: @"ClassicOne" ];
        [ m_classic1 setCode: 1 ];
        [ [ m_classic1 transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_classic1 transform ] setPosition: GLKVector3Make( -1.0f, 2.2f, 1.0f ) ];
        [ [ m_classic1 transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_classic2 = [ [ Plane alloc ] init: @"ClassicTwo" ];
        [ m_classic2 setCode: 2 ];
        [ [ m_classic2 transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_classic2 transform ] setPosition: GLKVector3Make( -1.0f, 0.85f, 1.0f ) ];
        [ [ m_classic2 transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_5Cube = [ [ Plane alloc ] init: @"5Cubes" ];
        [ m_5Cube setCode: 3 ];
        [ [ m_5Cube transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_5Cube transform ] setPosition: GLKVector3Make( -1.0f, -0.5f, 1.0f ) ];
        [ [ m_5Cube transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_6Cube = [ [ Plane alloc ] init: @"6Cubes" ];
        [ m_6Cube setCode: 4 ];
        [ [ m_6Cube transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_6Cube transform ] setPosition: GLKVector3Make( -1.0f, -1.85f, 1.0f ) ];
        [ [ m_6Cube transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_2x2x1 = [ [ Plane alloc ] init: @"2x2x1" ];
        [ m_2x2x1 setCode: 5 ];
        [ [ m_2x2x1 transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_2x2x1 transform ] setPosition: GLKVector3Make( -1.0f, -3.2f, 1.0f ) ];
        [ [ m_2x2x1 transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_clocks = [ [ Plane alloc ] init: @"ClocksGame" ];
        [ m_clocks setCode: 6 ];
        [ [ m_clocks transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_clocks transform ] setPosition: GLKVector3Make( -1.0f, -4.55f, 1.0f ) ];
        [ [ m_clocks transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_howToPlayButton = [ []]*/
        
        m_gameTitle = [ [ Texture alloc ] init: @"GameTitle" ];
        
        m_classic1 = [ [ Texture alloc ] init: @"ClassicOne" ];
        [ m_classic1 setCode: 1 ];
        m_howToPlayClassicOne = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlayClassicOne setCode: 7 ];
        
        m_classic2 = [ [ Texture alloc ] init: @"ClassicTwo" ];
        [ m_classic2 setCode: 2 ];
        m_howToPlayClassicTwo = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlayClassicTwo setCode: 8 ];
        
        m_5Cube = [ [ Texture alloc ] init: @"5Cubes" ];
        [ m_5Cube setCode: 3 ];
        m_howToPlayFive = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlayFive setCode: 9 ];
        
        m_6Cube = [ [ Texture alloc ] init: @"6Cubes" ];
        [ m_6Cube setCode: 4 ];
        m_howToPlaySix = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlaySix setCode: 10 ];
        
        m_2x2x1 = [ [ Texture alloc ] init: @"2x2x1" ];
        [ m_2x2x1 setCode: 5 ];
        m_howToPlaySquare = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlaySquare setCode: 11 ];
        
        m_clocks = [ [ Texture alloc ] init: @"ClocksGame" ];
        [ m_classic2 setCode: 6 ];
        m_howToPlayClocks = [ [ Texture alloc ] init: @"HowToPlayButton" ];
        [ m_howToPlayClocks setCode: 12 ];
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
}

- ( void ) update {
    
}

- ( void ) render {
    [ super render ];
    
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube1 withProjection: [ [ m_cube1 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube2 withProjection: [ [ m_cube2 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube3 withProjection: [ [ m_cube3 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube4 withProjection: [ [ m_cube4 transform ] getProjectionMatrix ] withCamera: m_camera ];
    
    if ( m_htp != nil ) {
        [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_htp withX: 200 withY: 150 withWidth: 400 withHeight: 300 ];
    }
    
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_gameTitle withX: 50 withY: 500 withWidth: 700 withHeight: 80 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_classic1 withX: 50 withY: 410 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_classic2 withX: 50 withY: 330 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_5Cube withX: 50 withY: 250 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_6Cube withX: 50 withY: 170 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_2x2x1 withX: 50 withY: 90 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_clocks withX: 50 withY: 10 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlayClassicOne withX: 680 withY: 410 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlayClassicTwo withX: 680 withY: 330 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlayFive withX: 680 withY: 250 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlaySix withX: 680 withY: 170 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlaySquare withX: 680 withY: 90 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_howToPlayClocks withX: 680 withY: 10 withWidth: 90 withHeight: 70 ];
}

- ( void ) receivedFocus {
    [ m_view addGestureRecognizer: m_tapGestureRecognizer ];
}

- ( void ) lostFocus {
    [ m_view removeGestureRecognizer: m_tapGestureRecognizer ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
    if ( m_htp != nil ) {
        m_htp = nil;
        return;
    }
    
    CGPoint point = [ sender locationInView: m_view ];
    
    NSInteger height = m_view.drawableHeight;
    NSInteger width = m_view.drawableWidth;
    Byte pixelColor[ 4 ] = { 0, };
    GLuint colorRenderbuffer;
    GLuint framebuffer;
    
    glGenFramebuffers( 1, &framebuffer );
    glBindFramebuffer( GL_FRAMEBUFFER, framebuffer );
    glGenRenderbuffers( 1, &colorRenderbuffer );
    glBindRenderbuffer( GL_RENDERBUFFER, colorRenderbuffer );
    
    glRenderbufferStorage( GL_RENDERBUFFER, GL_RGBA8_OES, ( int ) width, ( int ) height );
    glFramebufferRenderbuffer( GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer );
    
    GLenum status = glCheckFramebufferStatus( GL_FRAMEBUFFER );
    if ( status != GL_FRAMEBUFFER_COMPLETE ) {
        NSLog( @"Framebuffer status: %x", ( int ) status );
    }
    
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_gameTitle withX: 50 withY: 500 withWidth: 700 withHeight: 80 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_classic1 withX: 50 withY: 410 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_classic2 withX: 50 withY: 330 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_5Cube withX: 50 withY: 250 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_6Cube withX: 50 withY: 170 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_2x2x1 withX: 50 withY: 90 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_clocks withX: 50 withY: 10 withWidth: 610 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlayClassicOne withX: 680 withY: 410 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlayClassicTwo withX: 680 withY: 330 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlayFive withX: 680 withY: 250 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlaySix withX: 680 withY: 170 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlaySquare withX: 680 withY: 90 withWidth: 90 withHeight: 70 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_howToPlayClocks withX: 680 withY: 10 withWidth: 90 withHeight: 70 ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_classic1 getCode ] ) {
        CurrentScene = SCENE_CLASSIC_1_GAME;
    } else if ( value == [ m_classic2 getCode ] ) {
        CurrentScene = SCENE_CLASSIC_2_GAME;
    } else if ( value == [ m_5Cube getCode ] ) {
        CurrentScene = SCENE_FIVE_CUBE_GAME;
    } else if ( value == [ m_6Cube getCode ] ) {
        CurrentScene = SCENE_SIX_CUBE_GAME;
    } else if ( value == [ m_2x2x1 getCode ] ) {
        CurrentScene = SCENE_SQUARE_GAME;
    } else if ( value == [ m_clocks getCode ] ) {
        CurrentScene = SCENE_CLOCKS_GAME;
    } else if ( value == [ m_howToPlayClassicOne getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlayClassic" ];
    } else if ( value == [ m_howToPlayClassicTwo getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlayClassic" ];
    } else if ( value == [ m_howToPlayFive getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlayFiveCube" ];
    } else if ( value == [ m_howToPlaySix getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlaySixCube" ];
    } else if ( value == [ m_howToPlaySquare getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlaySquare" ];
    } else if ( value == [ m_howToPlayClocks getCode ] ) {
        m_htp = [ [ Texture alloc ] init: @"HowToPlayClocks" ];
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

@end