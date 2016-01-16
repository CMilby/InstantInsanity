//
//  GameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "GameScene.h"

#include "Constants.h"

@implementation GameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        m_pinchGestureRecognizer = [ [ UIPinchGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePinch: ) ];
        m_panGestureRecognizer = [ [ UIPanGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePan: ) ];
        
        // Swipe Gestures Start
        m_swipeGestureRecognizerLeft = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        
        m_swipeGestureRecognizerRight = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        m_swipeGestureRecognizerUp = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
        
        m_swipeGestureRecognizerDown = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
        
        m_swipeGestureRecognizerLeftTwo = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerLeftTwo.direction = UISwipeGestureRecognizerDirectionLeft;
        m_swipeGestureRecognizerLeftTwo.numberOfTouchesRequired = 2;
        
        m_swipeGestureRecognizerRightTwo = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerRightTwo.direction = UISwipeGestureRecognizerDirectionRight;
        m_swipeGestureRecognizerRightTwo.numberOfTouchesRequired = 2;
        // Swipe Gestures End
        
        m_stopwatch = [ [ Stopwatch alloc ] init ];
        
        m_floor = [ [ Plane alloc ] init: @"Floor" ];
        [ [ m_floor transform ] rotate: GLKVector3Make( 1.0f, 0.0f, 0.0f ) withAngle: 90.0f ];
        [ [ m_floor transform ] setScale: GLKVector3Make( 5.0f, 5.0f, 5.0f ) ];
        
        m_picked = false;
        m_shouldRotateX = m_shouldRotateY = m_shouldRotateZ = false;
        
        m_pauseButton = [ [ Texture alloc ] init: @"PauseImage" ];
        [ m_pauseButton setCode: 200 ];
        
        m_currentMenu = m_lastMenu = -1;
        m_menus = [ [ NSMutableArray alloc ] initWithCapacity: NUMBER_MENUS ];
        m_pauseMenu = [ [ PauseMenu alloc ] initWithView: m_view withShaders: m_shaders withCamera: m_camera withParent: self ];
        m_quitMenu = [ [ QuitMenu alloc ] initWithView: m_view withShaders: m_shaders withCamera: m_camera withParent: self ];
        m_winMenu = [ [ WinMenu alloc ] initWithView: m_view withShaders: m_shaders withCamera: m_camera withParent: self ];
        
        [ m_menus addObject: m_pauseMenu ];
        [ m_menus addObject: m_quitMenu ];
        [ m_menus addObject: m_winMenu ];
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
}

- ( void ) reset {
    [ self setCurrentMenu: MENU_NONE ];
    [ m_stopwatch reset ];
    
    for ( int i = 0; i < [ m_cubes count ]; i++ ) {
        [ m_cubes[ i ] setIsPicked: false ];
    }
    
    m_pickedCube = NULL;
    m_picked = false;
    
    m_panGestureRecognizer.enabled = true;
    
    // Start each cube at random orientation
    do {
        for ( int i = 0; i < [ m_cubes count ]; i++ ) {
            [ m_cubes[ i ] rotateRandom ];
        }
    } while ( [ self hasWon ] );
}

- ( void ) update {
    if ( m_lastMenu != m_currentMenu ) {
        if ( m_lastMenu != MENU_NONE ) {
            [ m_menus[ m_lastMenu ] lostFocus ];
        }
        if ( m_currentMenu != MENU_NONE ) {
            [ m_stopwatch pause ];
            [ m_menus[ m_currentMenu ] receivedFocus ];
        } else {
            [ m_stopwatch resume ];
        }
        m_lastMenu = m_currentMenu;
    }
    
    if ( m_currentMenu != MENU_NONE ) {
        [ m_menus[ m_currentMenu ] update ];
    }
    
    if ( m_shouldRotateX || m_shouldRotateY || m_shouldRotateZ ) {
        
        m_totalRotation += m_rotateX + m_rotateY + m_rotateZ;
        
        if ( m_shouldRotateX ) {
            [ [ m_pickedCube transform ] rotate: GLKVector3Make( 1.0f, 0.0f, 0.0f ) withAngle: m_rotateX ];
        }
        
        if ( m_shouldRotateY ) {
            [ [ m_pickedCube transform ] rotate: GLKVector3Make( 0.0f, 1.0f, 0.0f ) withAngle: m_rotateY ];
        }
        
        if ( m_shouldRotateZ ) {
            [ [ m_pickedCube transform ] rotate: GLKVector3Make( 0.0f, 0.0f, 1.0f ) withAngle: m_rotateZ ];
        }
        
        if ( abs( m_totalRotation ) % 90 == 0 ) {
            m_shouldRotateX = m_shouldRotateY = m_shouldRotateZ = false;
            m_rotateX = m_rotateY = m_rotateZ = 0;
            m_totalRotation = 0.0f;
            
            if ( [ self hasWon ] ) {
                [ m_stopwatch pause ];
                [ self lostFocus ];
                [ m_menus[ MENU_WIN ] receivedFocus ];
                m_currentMenu = MENU_WIN;
            }
        }
    }
}

- ( void ) render {
    if ( !m_picked ) {
        // Order doesnt matter
        for ( int i = 0; i < [ m_cubes count ]; i++ ) {
            [ m_shaders[ SHADER_STANDARD ] updateEntity: m_cubes[ i ] withProjection: [ [ m_cubes[ i ] transform ] getProjectionMatrix ] withCamera: m_camera ];
        }
    } else {
        // Render picked last
        NSMutableArray<RenderableEntity*> *array = [ self getPickedRender ];
        for ( int i = 0; i < [ array count ]; i++ ) {
            [ m_shaders[ SHADER_STANDARD ] updateEntity: array[ i ] withProjection: [ [ array[ i ] transform ] getProjectionMatrix ] withCamera: m_camera ];
        }
    }
    
    [ m_shaders[ SHADER_TEXT ] updateString: [ m_stopwatch getTimeString ] withX: 5 withY: 0 withSize: 32 ];
    [ m_shaders[ SHADER_OVERLAY ] updateTexture: m_pauseButton withX: 760 withY: 560 withSize: 32 ];
    
    if ( m_currentMenu != MENU_NONE ) {
        [ m_menus[ m_currentMenu ] render ];
    }
}

- ( void ) receivedFocus {
    [ m_view addGestureRecognizer: m_tapGestureRecognizer ];
    [ m_view addGestureRecognizer: m_panGestureRecognizer ];
    [ m_view addGestureRecognizer: m_pinchGestureRecognizer ];
    
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerLeft ];
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerRight ];
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerUp ];
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerDown ];
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerLeftTwo ];
    [ m_view addGestureRecognizer: m_swipeGestureRecognizerRightTwo ];
    
    [ self reset ];
}

- ( void ) lostFocus {
    [ m_view removeGestureRecognizer: m_tapGestureRecognizer ];
    [ m_view removeGestureRecognizer: m_panGestureRecognizer ];
    [ m_view removeGestureRecognizer: m_pinchGestureRecognizer ];
    
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerLeft ];
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerRight ];
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerUp ];
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerDown ];
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerLeftTwo ];
    [ m_view removeGestureRecognizer: m_swipeGestureRecognizerRightTwo ];
    
    [ m_stopwatch stop ];
}

- ( void ) setCubes: ( NSMutableArray<Cube*>* ) cubes {
    m_cubes = cubes;
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
    if ( m_shouldRotateX || m_shouldRotateY || m_shouldRotateZ ) {
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
    
    for ( int i = 0; i < [ m_cubes count ]; i++ ) {
        [ m_shaders[ SHADER_SELECTION ] updateEntity: m_cubes[ i ] withProjection: [ [ m_cubes[ i ] transform ] getProjectionMatrix ] withCamera:m_camera ];
    }
    [ m_shaders[ SHADER_SELECTION_OVERLAY ] updateTexture: m_pauseButton withX: 760 withY: 560 withSize: 32 ];
    
    CGFloat scale = UIScreen.mainScreen.scale;
    glReadPixels (point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
    
    NSUInteger value = pixelColor[ 0 ];
    
    if ( value == [ m_pauseButton getCode ] ) {
        m_currentMenu = MENU_PAUSE;
        [ self lostFocus ];
        [ m_menus[ m_currentMenu ] receivedFocus ];
        // NSLog( @"Pause Button" );
    } else if ( !m_picked ) {
        if ( value == 0 ) {
            return;
        }
        
        NSMutableArray<Cube*> *array = [ self getNotPickedCubes: ( int ) value ];
        for ( int i = 0; i < [ array count ]; i++ ) {
            [ array[ i ] setIsPicked: true ];
        }
        
        m_picked = true;
        m_panGestureRecognizer.enabled = false;
        
        NSLog( @"Front:  %i", [ m_pickedCube frontColor ] );
        NSLog( @"Back:   %i", [ m_pickedCube backColor ] );
        NSLog( @"Left:   %i", [ m_pickedCube leftColor ] );
        NSLog( @"Right:  %i", [ m_pickedCube rightColor ] );
        NSLog( @"Top:    %i", [ m_pickedCube topColor ] );
        NSLog( @"Bottom: %i", [ m_pickedCube bottomColor ] );
        
    } else if ( m_picked ) {
        for ( int i = 0; i < [ m_cubes count ]; i++ ) {
            [ m_cubes[ i ] setIsPicked: false ];
        }
        
        m_pickedCube = NULL;
        m_picked = false;
        
        m_panGestureRecognizer.enabled = true;
    }
    
    [ self render ];
    
    glDeleteRenderbuffers(1, &colorRenderbuffer);
    glDeleteFramebuffers(1, &framebuffer);
}

- ( void ) handlePinch: ( UIGestureRecognizer* ) sender {
    if ( sender.state == UIGestureRecognizerStateBegan ) {
        if ( [ sender numberOfTouches ] != 2 ) {
            return;
        }
        
        CGPoint pos1 = [ sender locationOfTouch: 0 inView: m_view ];;
        CGPoint pos2 = [ sender locationOfTouch: 1 inView: m_view ];
        float d = GLKVector2Distance( GLKVector2Make( pos1.x, pos1.y ), GLKVector2Make( pos2.x, pos2.y ) );
        [ m_camera startZooming: d ];
    } else if ( sender.state == UIGestureRecognizerStateEnded ) {
        [ m_camera stopZooming ];
        [ m_camera stopRotation ];
    } else {
        if ( [ sender numberOfTouches ] == 2 && [ m_camera isZoomingNow ] ) {
            CGPoint pos1 = [ sender locationOfTouch: 0 inView: m_view ];
            CGPoint pos2 = [ sender locationOfTouch: 1 inView: m_view ];
            float d = GLKVector2Distance( GLKVector2Make( pos1.x, pos1.y ), GLKVector2Make( pos2.x, pos2.y ) );
            [ m_camera updateZooming: d ];
        }
    }
}

- ( void ) handlePan: ( UIPanGestureRecognizer* ) sender {
    if ( sender.state == UIGestureRecognizerStateBegan ) {
        if ( ![ m_camera isRotatingNow ] ) {
            CGPoint pos = [ sender locationInView: m_view ];
            [ m_camera startRotation: pos.x yPos: pos.y ];
        }
    } else if ( sender.state == UIGestureRecognizerStateEnded ) {
        [ m_camera stopRotation ];
    } else {
        if ( [ m_camera isRotatingNow ] ) {
            CGPoint pos = [ sender locationInView: m_view ];
            [ m_camera updateRotation: pos.x yPos: pos.y ];
        }
    }
}

- ( void ) handleSwipe: ( UISwipeGestureRecognizer* ) sender {
    if ( !m_picked ) {
        return;
    }
    
    if ( m_shouldRotateX || m_shouldRotateY || m_shouldRotateZ ) {
        return;
    }
    
    if ( ![ m_stopwatch isRunning ] ) {
        [ m_stopwatch start ];
    }
    
    if ( sender.numberOfTouches == 1 ) {
        if ( sender.direction == UISwipeGestureRecognizerDirectionLeft ) {
            m_totalRotation = 0;
            m_shouldRotateY = true;
            m_rotateY = -ROTATION_AMOUNT;
            [ m_pickedCube rotateY: true ];
        } else if ( sender.direction == UISwipeGestureRecognizerDirectionRight ) {
            m_totalRotation = 0;
            m_shouldRotateY = true;
            m_rotateY = ROTATION_AMOUNT;
            [ m_pickedCube rotateY: false ];
        } else if ( sender.direction == UISwipeGestureRecognizerDirectionUp ) {
            GLKVector3 forward = [ m_camera getCurrentViewPosition ];
            if ( fabsf( forward.x ) > fabs( forward.z ) ) {
                m_rotateZ = ( forward.x < 0 ) ? -ROTATION_AMOUNT : ROTATION_AMOUNT;
                m_shouldRotateZ = true;
                [ m_pickedCube rotateZ: m_rotateZ < 0 ];
            } else {
                m_rotateX = ( forward.z < 0 ) ? ROTATION_AMOUNT : -ROTATION_AMOUNT;
                m_shouldRotateX = true;
                [ m_pickedCube rotateX: m_rotateX < 0 ];
            }
            m_totalRotation = 0;
        } else if ( sender.direction == UISwipeGestureRecognizerDirectionDown ) {
            GLKVector3 forward = [ m_camera getCurrentViewPosition ];
            if ( fabsf( forward.x ) > fabs( forward.z ) ) {
                m_rotateZ = ( forward.x < 0 ) ? ROTATION_AMOUNT : -ROTATION_AMOUNT;
                m_shouldRotateZ = true;
                [ m_pickedCube rotateZ: m_rotateZ < 0 ];
            } else {
                m_rotateX = ( forward.z < 0 ) ? -ROTATION_AMOUNT : ROTATION_AMOUNT;
                m_shouldRotateX = true;
                [ m_pickedCube rotateX: m_rotateX < 0 ];
            }
            m_totalRotation = 0;
        }
    } else if ( sender.numberOfTouches == 2 ) {
        GLKVector3 forward = [ m_camera getCurrentViewPosition ];
        if ( sender.direction == UISwipeGestureRecognizerDirectionLeft ) {
            if ( fabs( forward.x ) > fabs( forward.z ) ) {
                m_rotateX = ( forward.x < 0 ) ? -ROTATION_AMOUNT : ROTATION_AMOUNT;
                m_shouldRotateX = true;
                [ m_pickedCube rotateX: m_rotateX < 0 ];
            } else {
                m_rotateZ = ( forward.z < 0 ) ? -ROTATION_AMOUNT : ROTATION_AMOUNT;
                m_shouldRotateZ = true;
                [ m_pickedCube rotateZ: m_rotateZ < 0 ];
            }
        } else if ( sender.direction == UISwipeGestureRecognizerDirectionRight ) {
            if ( fabs( forward.x ) > fabs( forward.z ) ) {
                m_rotateX = ( forward.x < 0 ) ? ROTATION_AMOUNT : -ROTATION_AMOUNT;
                m_shouldRotateX = true;
                [ m_pickedCube rotateX: m_rotateX < 0 ];
            } else {
                m_rotateZ = ( forward.z < 0 ) ? ROTATION_AMOUNT : -ROTATION_AMOUNT;
                m_shouldRotateZ = true;
                [ m_pickedCube rotateZ: m_rotateZ < 0 ];
            }
        }
    }
}

- ( NSMutableArray<Cube*>* ) getNotPickedCubes: ( int ) value {
    NSMutableArray<Cube*> *array = [ [ NSMutableArray alloc ] initWithCapacity: [ m_cubes count ] - 1 ];
    for ( int i = 0; i < [ m_cubes count ]; i++ ) {
        if ( value == [ m_cubes[ i ] getCode ] ) {
            for ( int j = 0; j < [ m_cubes count ]; j++ ) {
                if ( i != j ) [ array addObject: m_cubes[ j ] ];
            }
            m_pickedCube = m_cubes[ i ];
            break;
        }
    }
    
    return array;
}

// Generic picker
// May need overriden
- ( NSMutableArray<RenderableEntity*>* ) getPickedRender {
    NSMutableArray<RenderableEntity*> *array = [ [ NSMutableArray alloc ] initWithCapacity: [ m_cubes count ] ];
    for ( int i = 0; i < [ m_cubes count ]; i++ ) {
        if ( ![ m_cubes[ i ] isPicked ] ) {
            [ array addObject: m_cubes[ i ] ];
            for ( int j = 0; j < [ m_cubes count ]; j++ ) {
                if ( i != j ) [ array addObject: m_cubes[ j ] ];
            }
            break;
        }
    }
    
    return array;
}

// Will need overriden
- ( bool ) hasWon {
    return false;
}

- ( void ) setCurrentMenu: ( int ) currentMenu {
    m_currentMenu = currentMenu;
}

@end