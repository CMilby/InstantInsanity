//
//  Game.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/8/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Game.h"

#include "Constants.h"

@implementation Game {
  
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        m_tapGestureRecognizer = [ [ UITapGestureRecognizer alloc ] initWithTarget: self action: @selector( handleTap: ) ];
        // [ m_view addGestureRecognizer: m_tapGestureRecognizer ];
        
        m_pinchGestureRecognizer = [ [ UIPinchGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePinch: ) ];
        // [ m_view addGestureRecognizer: m_pinchGestureRecognizer ];
        
        m_panGestureRecognizer = [ [ UIPanGestureRecognizer alloc ] initWithTarget: self action: @selector( handlePan: ) ];
        // [ m_view addGestureRecognizer: m_panGestureRecognizer ];

        // Swipe Gestures Start
        m_swipeGestureRecognizerLeft = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerLeft ];
        
        m_swipeGestureRecognizerRight = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerRight.direction = UISwipeGestureRecognizerDirectionRight;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerRight ];
        
        m_swipeGestureRecognizerUp = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerUp.direction = UISwipeGestureRecognizerDirectionUp;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerUp ];
        
        m_swipeGestureRecognizerDown = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerDown.direction = UISwipeGestureRecognizerDirectionDown;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerDown ];
        
        m_swipeGestureRecognizerLeftTwo = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerLeftTwo.direction = UISwipeGestureRecognizerDirectionLeft;
        m_swipeGestureRecognizerLeftTwo.numberOfTouchesRequired = 2;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerLeftTwo ];
        
        
        m_swipeGestureRecognizerRightTwo = [ [ UISwipeGestureRecognizer alloc ] initWithTarget: self action: @selector( handleSwipe: ) ];
        m_swipeGestureRecognizerRightTwo.direction = UISwipeGestureRecognizerDirectionRight;
        m_swipeGestureRecognizerRightTwo.numberOfTouchesRequired = 2;
        // [ m_view addGestureRecognizer: m_swipeGestureRecognizerRightTwo ];
        // Swipe Gestures End
    
        
        m_cube1 = [ [ Cube alloc ] init: @"Cube1" ];
        [ [ m_cube1 transform ] setPosition: GLKVector3Make( 0.0, -4.5f, 0.0 ) ];
        [ m_cube1 setCode: 8 ];
        [ m_cube1 setFrontColor: RED_COLOR ];
        [ m_cube1 setBackColor: RED_COLOR ];
        [ m_cube1 setLeftColor: RED_COLOR ];
        [ m_cube1 setRightColor: GREEN_COLOR ];
        [ m_cube1 setTopColor: YELLOW_COLOR ];
        [ m_cube1 setBottomColor: BLUE_COLOR ];
        
        
        m_cube2 = [ [ Cube alloc ] init: @"Cube2" ];
        [ [ m_cube2 transform ] setPosition: GLKVector3Make( 0.0, -1.5f, 0.0 ) ];
        [ m_cube2 setCode: 32 ];
        [ m_cube2 setFrontColor: YELLOW_COLOR ];
        [ m_cube2 setBackColor: RED_COLOR ];
        [ m_cube2 setLeftColor: RED_COLOR ];
        [ m_cube2 setRightColor: BLUE_COLOR ];
        [ m_cube2 setTopColor: YELLOW_COLOR ];
        [ m_cube2 setBottomColor: GREEN_COLOR ];
        
        
        m_cube3 = [ [ Cube alloc ] init: @"Cube3" ];
        [ [ m_cube3 transform ] setPosition: GLKVector3Make( 0.0, 1.5f, 0.0 ) ];
        [ m_cube3 setCode: 64 ];
        [ m_cube3 setFrontColor: GREEN_COLOR ];
        [ m_cube3 setBackColor: GREEN_COLOR ];
        [ m_cube3 setLeftColor: BLUE_COLOR ];
        [ m_cube3 setRightColor: RED_COLOR ];
        [ m_cube3 setTopColor: BLUE_COLOR];
        [ m_cube3 setBottomColor: YELLOW_COLOR ];
        
        
        m_cube4 = [ [ Cube alloc ] init: @"Cube4" ];
        [ [ m_cube4 transform ] setPosition: GLKVector3Make( 0.0, 4.5f, 0.0 ) ];
        [ m_cube4 setCode: 128 ];
        [ m_cube4 setFrontColor: YELLOW_COLOR ];
        [ m_cube4 setBackColor: BLUE_COLOR ];
        [ m_cube4 setLeftColor: GREEN_COLOR ];
        [ m_cube4 setRightColor: RED_COLOR ];
        [ m_cube4 setTopColor: YELLOW_COLOR ];
        [ m_cube4 setBottomColor: GREEN_COLOR ];
        
        m_textShader = [ [ TextShader alloc ] init: @"Courier_New" ];
        m_stopwatch = [ [ Stopwatch alloc ] init ];
        
        m_picked = false;
        m_shouldRotateX = m_shouldRotateY = m_shouldRotateZ = false;
    }
    return self;
}

- ( void ) cleanup {
    [ super cleanup ];
    
    [ m_cube1 cleanup ];
    [ m_cube2 cleanup ];
    [ m_cube3 cleanup ];
    [ m_cube4 cleanup ];
    
    [ m_textShader cleanup ];
}

- ( void ) update {
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
                [ m_stopwatch stop ];
                NSLog( @"Won" );
            }
        }
    }
}

- ( void ) render {
    [ m_textShader render: [ m_stopwatch getTimeString ] withX: 5 withY: 0 withSize: 32 ];
    
    if ( !m_picked ) {
        // Order doesnt matter
        [ m_shaders[ 0 ] update: m_cube1 withProjection: [ [ m_cube1 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ 0 ] update: m_cube2 withProjection: [ [ m_cube2 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ 0 ] update: m_cube3 withProjection: [ [ m_cube3 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ 0 ] update: m_cube4 withProjection: [ [ m_cube4 transform ] getProjectionMatrix ] withCamera: m_camera ];
    } else {
        // Render picked last
        NSMutableArray<RenderableEntity*> *array = [ self getPickedRender ];
        for ( int i = 0; i < [ array count ]; i++ ) {
            [ m_shaders[ 0 ] update: array[ i ] withProjection: [ [ array[ i ] transform ] getProjectionMatrix ] withCamera: m_camera ];
        }
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
}

- ( void ) handleTap: ( UITapGestureRecognizer* ) sender {
    if ( m_shouldRotateX || m_shouldRotateY || m_shouldRotateZ ) {
        return;
    }
    
    if ( !m_picked ) {
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
    
        [ m_shaders[ SHADER_SELECTION ] update: m_cube1 withProjection: [ [ m_cube1 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ SHADER_SELECTION ] update: m_cube2 withProjection: [ [ m_cube2 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ SHADER_SELECTION ] update: m_cube3 withProjection: [ [ m_cube3 transform ] getProjectionMatrix ] withCamera: m_camera ];
        [ m_shaders[ SHADER_SELECTION ] update: m_cube4 withProjection: [ [ m_cube4 transform ] getProjectionMatrix ] withCamera: m_camera ];
        
        CGFloat scale = UIScreen.mainScreen.scale;
        glReadPixels (point.x * scale, ( height - ( point.y * scale ) ), 1, 1, GL_RGBA, GL_UNSIGNED_BYTE, pixelColor );
        
        NSUInteger value = pixelColor[ 0 ];
        if ( value == 0 ) {
            return;
        }
        
        NSMutableArray<Cube*> *array = [ self getNotPickedCubes: ( int ) value ];
        for ( int i = 0; i < [ array count ]; i++ ) {
            [ array[ i ] setIsPicked: true ];
        }
        
        m_picked = true;
    
        [ self render ];
        
        m_panGestureRecognizer.enabled = false;
        
        glDeleteRenderbuffers(1, &colorRenderbuffer);
        glDeleteFramebuffers(1, &framebuffer);
    } else {
        [ m_cube1 setIsPicked: false ];
        [ m_cube2 setIsPicked: false ];
        [ m_cube3 setIsPicked: false ];
        [ m_cube4 setIsPicked: false ];
        m_pickedCube = NULL;
        m_picked = false;
        
        m_panGestureRecognizer.enabled = true;
    }
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
    NSMutableArray<Cube*> *array = [ [ NSMutableArray alloc ] initWithCapacity: 3 ];
    if ( value == [ m_cube1 getCode ] ) {
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube4 ];
        m_pickedCube = m_cube1;
    }
    if ( value == [ m_cube2 getCode ] ) {
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube4 ];
        m_pickedCube = m_cube2;
    }
    if ( value == [ m_cube3 getCode ] ) {
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube4 ];
        m_pickedCube = m_cube3;
    }
    if ( value == [ m_cube4 getCode ] ) {
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube3 ];
        m_pickedCube = m_cube4;
    }
    return array;
}

- ( NSMutableArray<RenderableEntity*>* ) getPickedRender {
    NSMutableArray<RenderableEntity*> *array = [ [ NSMutableArray alloc ] initWithCapacity: 4 ];
    if ( ![ m_cube1 isPicked ] ) {
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube4 ];
    }
    if ( ![ m_cube2 isPicked ] ) {
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube4 ];
    }
    if ( ![ m_cube3 isPicked ] ) {
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube1 ];
        [ array addObject: m_cube4 ];
    }
    if ( ![ m_cube4 isPicked ] ) {
        [ array addObject: m_cube4 ];
        [ array addObject: m_cube3 ];
        [ array addObject: m_cube2 ];
        [ array addObject: m_cube1 ];
    }
    return array;
}

- ( bool ) hasWon {
    NSMutableArray *array = [ [ NSMutableArray alloc ] initWithCapacity: 3 ];
    for ( int i = 0; i < 4; i++ ) {
        [ array addObject: [ NSNumber numberWithInt: [ m_cube1 color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cube2 color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cube2 color: i ] ] ];
    
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cube3 color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cube3 color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cube4 color: i ] ] ] )
            return false;
        
        [ array removeAllObjects ];
    }
    
    return true;
}

@end





















