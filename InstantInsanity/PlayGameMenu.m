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
        
        m_gameTitle = [ [ Plane alloc ] init: @"GameTitle" ];
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

    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
}

- ( void ) update {
    
}

- ( void ) render {
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube1 withProjection: [ [ m_cube1 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube2 withProjection: [ [ m_cube2 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube3 withProjection: [ [ m_cube3 transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cube4 withProjection: [ [ m_cube4 transform ] getProjectionMatrix ] withCamera: m_camera ];
    
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_gameTitle withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_classic1 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_classic2 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_5Cube withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_6Cube withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_2x2x1 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_clocks withProjection: m_orthMatrix withCamera: m_camera ];
}

- ( void ) receivedFocus {
    [ m_view addGestureRecognizer: m_tapGestureRecognizer ];
}

- ( void ) lostFocus {
    [ m_view removeGestureRecognizer: m_tapGestureRecognizer ];
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
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
    
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_classic1 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_classic2 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_5Cube withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_6Cube withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_2x2x1 withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_clocks withProjection: m_orthMatrix withCamera: m_camera ];
    
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
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

@end