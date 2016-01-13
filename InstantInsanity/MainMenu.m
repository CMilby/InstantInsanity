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

- ( id ) init: ( Camera* ) camera inView: ( GLKView* ) view {
    if ( self = [ super init ] ) {
        m_view = view;
        
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        [ m_view addGestureRecognizer: m_tapGestureRecognizer ];
        
        m_cube1 = [ [ Cube alloc ] init: @"Cube1" ];
        [ [ m_cube1 transform ] setPosition: GLKVector3Make( 0.0, -4.5f, 0.0 ) ];
        m_cube2 = [ [ Cube alloc ] init: @"Cube2" ];
        [ [ m_cube2 transform ] setPosition: GLKVector3Make( 0.0, -1.5f, 0.0 ) ];
        m_cube3 = [ [ Cube alloc ] init: @"Cube3" ];
        [ [ m_cube3 transform ] setPosition: GLKVector3Make( 0.0, 1.5f, 0.0 ) ];
        m_cube4 = [ [ Cube alloc ] init: @"Cube4" ];
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
        
        m_howToPlay = [ [ Plane alloc ] init: @"HowToPlay" ];
        [ m_howToPlay setCode: 3 ];
        [ [ m_howToPlay transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: -225.0f ];
        [ [ m_howToPlay transform ] setPosition: GLKVector3Make( -1, -2.0f, 1 ) ];
        [ [ m_howToPlay transform ] setScale: GLKVector3Make( 2.66, 0.66, 0.56 ) ];
        
        m_standardShader = [ [ Shader alloc ] init: @"StandardShader" withFrag: @"StandardShader" ];
        [ m_standardShader addUniform: @"mvp" ];
        [ m_standardShader addUniform: @"sampler" ];
        [ m_standardShader addUniform: @"transparent" ];
        
        m_selectionShader = [ [ Shader alloc ] init: @"SelectionShader" withFrag: @"SelectionShader" ];
        [ m_selectionShader addUniform: @"mvp" ];
        [ m_selectionShader addUniform: @"code" ];
        
        m_camera = camera;
    }
    return self;
}

- ( void ) update {
    
}

- ( void ) render {
    [ self renderHelperTexture: m_cube1 ];
    [ self renderHelperTexture: m_cube2 ];
    [ self renderHelperTexture: m_cube3 ];
    [ self renderHelperTexture: m_cube4 ];
    
    [ self renderHelperTexture: m_gameTitle ];
    [ self renderHelperTexture: m_playGame ];
    [ self renderHelperTexture: m_howToPlay ];
}

- ( void ) renderHelperTexture: ( RenderableEntity* ) entity {
    [ m_standardShader bind ];
    
    [ entity bind ];
    [ m_standardShader updateUniform: @"sampler" withInt: 0 ];
    
    GLKMatrix4 mvp = GLKMatrix4Multiply( GLKMatrix4Multiply( [ [ entity transform ] getProjectionMatrix ], [ m_camera getViewMatrix ] ), [ [ entity transform ] getModelMatrix ] );
    [ m_standardShader updateUniform: @"mvp" withMatrix4: mvp ];
    [ m_standardShader updateUniform: @"transparent" withInt: [ entity isPicked ] ? 0 : 1 ];
    
    glEnable( GL_BLEND );
    glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA );
    
    [ entity render: m_standardShader withCamera: m_camera ];
    
    glDisable( GL_BLEND );
}

- ( void ) renderHelperSelection: ( RenderableEntity* ) entity {
    [ m_selectionShader bind ];
    
    GLKMatrix4 mvp = GLKMatrix4Multiply( GLKMatrix4Multiply( [ [ entity transform ] getProjectionMatrix ], [ m_camera getViewMatrix ] ), [ [ entity transform ] getModelMatrix ] );
    [ m_selectionShader updateUniform: @"mvp" withMatrix4: mvp ];
    [ m_selectionShader updateUniform: @"code" withFloat: [ entity getCode ] ];
    
    [ entity render: m_selectionShader withCamera: m_camera ];
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
    
    [ self renderHelperSelection: m_gameTitle ];
    [ self renderHelperSelection: m_playGame ];
    [ self renderHelperSelection: m_howToPlay ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels( point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    if ( value == 0 ) {
        return;
    }
    
    if ( value == [ m_playGame getCode ] ) {
        NSLog( @"Play game" );
    } else if ( value == [ m_howToPlay getCode ] ) {
        NSLog( @"How to play" );
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

@end