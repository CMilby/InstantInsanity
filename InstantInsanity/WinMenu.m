//
//  WinMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "WinMenu.h"

#include "GameScene.h"

@implementation WinMenu {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera withParent: ( GameScene* ) parent {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        
        m_parent = parent;
        
        m_mainMenuButton = [ [ Texture alloc ] init: @"MainMenuButton" ];
        [ m_mainMenuButton setCode: 1 ];
        m_playAgainButton = [ [ Texture alloc ] init: @"PlayAgainButton" ];
        [ m_playAgainButton setCode: 2 ];
        
    }
    return self;
}

- ( void ) render {
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_mainMenuButton withX: 310 withY: 210 withWidth: 90 withHeight: 50 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_playAgainButton withX: 410 withY: 210 withWidth: 90 withHeight: 50 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_winTexture withX: 300 withY: 200 withWidth: 200 withHeight: 200 ];
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
    
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_playAgainButton withX: 410 withY: 210 withWidth: 90 withHeight: 50 ];
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_mainMenuButton withX: 310 withY: 210 withWidth: 90 withHeight: 50 ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_playAgainButton getCode ] ) {
        [ self lostFocus ];
        [ m_parent receivedFocus ];
        [ m_parent reset ];
    } else if ( value == [ m_mainMenuButton getCode ] ) {
        [ self lostFocus ];
        CurrentScene = SCENE_MAIN_MENU;
    }
    
    [ self render ];
    
    glDeleteRenderbuffers( 1, &colorRenderbuffer );
    glDeleteFramebuffers( 1, &framebuffer );
}

- ( void ) setTexture: ( Texture* ) texture {
    m_winTexture = texture;
}

@end