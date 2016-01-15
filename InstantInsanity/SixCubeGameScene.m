//
//  SixCubeGameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "SixCubeGameScene.h"

#include "Constants.h"

@implementation SixCubeGameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        Cube *cube1 = [ [ Cube alloc ] init: @"Six_Cube_Cube_1" ];
        [ [ cube1 transform ] setPosition: GLKVector3Make( 0.0f, -7.5f, 0.0f ) ];
        [ cube1 setCode: 1 ];
        [ cube1 setFrontColor: RED_COLOR ];
        [ cube1 setBackColor: ORANGE_COLOR ];
        [ cube1 setLeftColor: CYAN_COLOR ];
        [ cube1 setRightColor: GREEN_COLOR ];
        [ cube1 setTopColor: BLUE_COLOR ];
        [ cube1 setBottomColor: YELLOW_COLOR ];
        
        Cube *cube2 = [ [ Cube alloc ] init: @"Six_Cube_Cube_2" ];
        [ [ cube2 transform ] setPosition: GLKVector3Make( 0.0f, -4.5f, 0.0f ) ];
        [ cube2 setCode: 2 ];
        [ cube2 setFrontColor: GREEN_COLOR ];
        [ cube2 setBackColor: ORANGE_COLOR ];
        [ cube2 setLeftColor: CYAN_COLOR ];
        [ cube2 setRightColor: RED_COLOR ];
        [ cube2 setTopColor: BLUE_COLOR ];
        [ cube2 setBottomColor: YELLOW_COLOR ];
        
        Cube *cube3 = [ [ Cube alloc ] init: @"Six_Cube_Cube_3" ];
        [ [ cube3 transform ] setPosition: GLKVector3Make( 0.0f, -1.5f, 0.0f ) ];
        [ cube3 setCode: 3 ];
        [ cube3 setFrontColor: CYAN_COLOR ];
        [ cube3 setBackColor: ORANGE_COLOR ];
        [ cube3 setLeftColor: GREEN_COLOR ];
        [ cube3 setRightColor: YELLOW_COLOR ];
        [ cube3 setTopColor: BLUE_COLOR ];
        [ cube3 setBottomColor: RED_COLOR ];
        
        Cube *cube4 = [ [ Cube alloc ] init: @"Six_Cube_Cube_4" ];
        [ [ cube4 transform ] setPosition: GLKVector3Make( 0.0f, 1.5f, 0.0f ) ];
        [ cube4 setCode: 4 ];
        [ cube4 setFrontColor: YELLOW_COLOR ];
        [ cube4 setBackColor: ORANGE_COLOR ];
        [ cube4 setLeftColor: GREEN_COLOR ];
        [ cube4 setRightColor: CYAN_COLOR ];
        [ cube4 setTopColor: BLUE_COLOR ];
        [ cube4 setBottomColor: RED_COLOR ];
        
        Cube *cube5 = [ [ Cube alloc ] init: @"Six_Cube_Cube_5" ];
        [ [ cube5 transform ] setPosition: GLKVector3Make( 0.0f, 4.5f, 0.0f ) ];
        [ cube5 setCode: 5 ];
        [ cube5 setFrontColor: GREEN_COLOR ];
        [ cube5 setBackColor: ORANGE_COLOR ];
        [ cube5 setLeftColor: YELLOW_COLOR ];
        [ cube5 setRightColor: RED_COLOR ];
        [ cube5 setTopColor: BLUE_COLOR ];
        [ cube5 setBottomColor: CYAN_COLOR ];
        
        Cube *cube6 = [ [ Cube alloc ] init: @"Six_Cube_Cube_6" ];
        [ [ cube6 transform ] setPosition: GLKVector3Make( 0.0f, 7.5f, 0.0f ) ];
        [ cube6 setCode: 6 ];
        [ cube6 setFrontColor: CYAN_COLOR ];
        [ cube6 setBackColor: ORANGE_COLOR ];
        [ cube6 setLeftColor: RED_COLOR ];
        [ cube6 setRightColor: YELLOW_COLOR ];
        [ cube6 setTopColor: GREEN_COLOR ];
        [ cube6 setBottomColor: BLUE_COLOR ];
        
        m_cubes = [ [ NSMutableArray alloc ] initWithCapacity: 6 ];
        [ m_cubes addObject: cube1 ];
        [ m_cubes addObject: cube2 ];
        [ m_cubes addObject: cube3 ];
        [ m_cubes addObject: cube4 ];
        [ m_cubes addObject: cube5 ];
        [ m_cubes addObject: cube6 ];
        
        [ m_winMenu setTexture: [ [ Texture alloc ] init: @"WinScreenSixCube" ] ];
        [ self reset ];
    }
    return self;
}

- ( bool ) hasWon {
    NSMutableArray *array = [ [ NSMutableArray alloc ] initWithCapacity: 5 ];
    for ( int i = 0; i < 4; i++ ) {
        [ array addObject: [ NSNumber numberWithInt: [ m_cubes[ 0 ] color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cubes[ 1 ] color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cubes[ 1 ] color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cubes[ 2 ] color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cubes[ 2 ] color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cubes[ 3 ] color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cubes[ 3 ] color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cubes[ 4 ] color: i ] ] ] )
            return false;
        [ array addObject: [ NSNumber numberWithInt: [ m_cubes[ 4 ] color: i ] ] ];
        
        if ( [ array containsObject: [ NSNumber numberWithInt: [ m_cubes[ 5 ] color: i ] ] ] )
            return false;
        
        [ array removeAllObjects ];
    }
    
    return true;
}

@end