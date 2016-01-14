//
//  QuitMenu.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "QuitMenu.h"

@implementation QuitMenu {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        
        m_quitMenu = [ [ Plane alloc ] init: @"QuitMenu" ];
        
        m_yesButton = [ [ Plane alloc ] init: @"YesButton" ];
        [ m_yesButton setCode: 1 ];
        m_noButton = [ [ Plane alloc ] init: @"NoButton" ];
        [ m_noButton setCode: 2 ];
    }
    return self;
}

- ( void ) render {
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_quitMenu withProjection: m_orthMatrix withCamera:m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_yesButton withProjection: m_orthMatrix withCamera:m_camera ];
    [ m_shaders[ SHADER_STANDARD ] updateEntity: m_noButton withProjection: m_orthMatrix withCamera:m_camera ];
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
    
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_yesButton withProjection: m_orthMatrix withCamera: m_camera ];
    [ m_shaders[ SHADER_SELECTION ] updateEntity: m_noButton withProjection: m_orthMatrix withCamera: m_camera ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_yesButton getCode ] ) {
    
    } else if ( value == [ m_noButton getCode ] ) {
        
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

@end