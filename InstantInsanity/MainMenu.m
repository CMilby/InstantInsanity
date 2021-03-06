//
//  MainMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "MainMenu.h"

@implementation MainMenu {
    
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
        [ m_gameTitle setCode: 1 ];
        [ [ m_gameTitle transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_gameTitle transform ] setPosition: GLKVector3Make( -1, 1.5, 1 ) ];
        [ [ m_gameTitle transform ] setScale: GLKVector3Make( 4, 1, 0.85 ) ];
        
        m_playGame = [ [ Plane alloc ] init: @"PlayGame" ];
        [ m_playGame setCode: 2 ];
        [ [ m_playGame transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_playGame transform ] setPosition: GLKVector3Make( -1, -0.5, 1 ) ];
        [ [ m_playGame transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
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
    
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_gameTitle withProjection: [ [ m_gameTitle transform ] getProjectionMatrix ] withCamera: m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_playGame withProjection: m_orthMatrix withCamera: m_camera ];
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
    
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_playGame withProjection: m_orthMatrix withCamera: m_camera ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_playGame getCode ] ) {
        CurrentScene = SCENE_PLAY_GAME_MENU;
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

@end