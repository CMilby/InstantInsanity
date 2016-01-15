//
//  PauseMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "PauseMenu.h"

#include "GameScene.h"

@implementation PauseMenu {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        
        m_parent = parent;
        
        m_pauseMenu = [ [ Texture alloc ] init: @"PauseMenu" ];
        
        m_mainMenuButton = [ [ Texture alloc ] init: @"MainMenuButton" ];
        [ m_mainMenuButton setCode: 1 ];
        m_resumeButton = [ [ Texture alloc ] init: @"ResumeButton" ];
        [ m_resumeButton setCode: 2 ];
    }
    return self;
}

- ( void ) render {
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_resumeButton withX: 210 withY: 160 withWidth: 190 withHeight: 50 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_mainMenuButton withX: 410 withY: 160 withWidth: 190 withHeight: 50 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_pauseMenu withX: 200 withY: 150 withWidth: 400 withHeight: 300 ];
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
    
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_resumeButton withX: 210 withY: 160 withWidth: 190 withHeight: 50 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_mainMenuButton withX: 410 withY: 160 withWidth: 190 withHeight: 50 ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_resumeButton getCode ] ) {
        [ m_parent setCurrentMenu: MENU_NONE ];
        [ m_parent receivedFocus ];
    } else if ( value == [ m_mainMenuButton getCode ] ) {
        [ m_parent setCurrentMenu: MENU_QUIT ];
    }
    
    [ self render ];
    
    glDeleteRenderbuffers( 1, &colorRenderbuffer );
    glDeleteFramebuffers( 1, &framebuffer );
}

@end