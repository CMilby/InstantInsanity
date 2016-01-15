//
//  FiveColorGameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "FiveCubeGameScene.h"

#include "Constants.h"

@implementation FiveCubeGameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        Cube *cube1 = [ [ Cube alloc ] init: @"Five_Cube_Cube_1" ];
        [ [ cube1 transform ] setPosition: GLKVector3Make( 0.0f, -6.0f, 0.0f ) ];
        [ cube1 setCode: 1 ];
        [ cube1 setFrontColor: CYAN_COLOR ];
        [ cube1 setBackColor: YELLOW_COLOR ];
        [ cube1 setLeftColor: PINK_COLOR ];
        [ cube1 setRightColor: BLUE_COLOR];
        [ cube1 setTopColor: YELLOW_COLOR ];
        [ cube1 setBottomColor: GREEN_COLOR ];
        
        Cube *cube2 = [ [ Cube alloc ] init: @"Five_Cube_Cube_2" ];
        [ [ cube2 transform ] setPosition: GLKVector3Make( 0.0f, -3.0f, 0.0f ) ];
        [ cube2 setCode: 2 ];
        [ cube2 setFrontColor: YELLOW_COLOR ];
        [ cube2 setBackColor: BLUE_COLOR ];
        [ cube2 setLeftColor: CYAN_COLOR ];
        [ cube2 setRightColor: PINK_COLOR ];
        [ cube2 setTopColor: BLUE_COLOR ];
        [ cube2 setBottomColor: GREEN_COLOR ];
        
        Cube *cube3 = [ [ Cube alloc ] init: @"Five_Cube_Cube_3" ];
        [ [ cube3 transform ] setPosition: GLKVector3Make( 0.0f, 0.0f, 0.0f ) ];
        [ cube3 setCode: 3 ];
        [ cube3 setFrontColor: CYAN_COLOR ];
        [ cube3 setBackColor: GREEN_COLOR ];
        [ cube3 setLeftColor: PINK_COLOR ];
        [ cube3 setRightColor: YELLOW_COLOR ];
        [ cube3 setTopColor: GREEN_COLOR ];
        [ cube3 setBottomColor: BLUE_COLOR ];
        
        Cube *cube4 = [ [ Cube alloc ] init: @"Five_Cube_Cube_4" ];
        [ [ cube4 transform ] setPosition: GLKVector3Make( 0.0f, 3.0f, 0.0f ) ];
        [ cube4 setCode: 4 ];
        [ cube4 setFrontColor: CYAN_COLOR ];
        [ cube4 setBackColor: PINK_COLOR ];
        [ cube4 setLeftColor: GREEN_COLOR ];
        [ cube4 setRightColor: BLUE_COLOR ];
        [ cube4 setTopColor: PINK_COLOR ];
        [ cube4 setBottomColor: YELLOW_COLOR ];
        
        Cube *cube5 = [ [ Cube alloc ] init: @"Five_Cube_Cube_5" ];
        [ [ cube5 transform ] setPosition: GLKVector3Make( 0.0f, 6.0f, 0.0f ) ];
        [ cube5 setCode: 5 ];
        [ cube5 setFrontColor: YELLOW_COLOR ];
        [ cube5 setBackColor: CYAN_COLOR ];
        [ cube5 setLeftColor: GREEN_COLOR ];
        [ cube5 setRightColor: PINK_COLOR ];
        [ cube5 setTopColor: CYAN_COLOR ];
        [ cube5 setBottomColor: BLUE_COLOR ];
        
        m_cubes = [ [ NSMutableArray alloc ] initWithCapacity: 5 ];
        [ m_cubes addObject: cube1 ];
        [ m_cubes addObject: cube2 ];
        [ m_cubes addObject: cube3 ];
        [ m_cubes addObject: cube4 ];
        [ m_cubes addObject: cube5 ];
        
        [ m_winMenu setTexture: [ [ Texture alloc ] init: @"WinScreenFiveCube" ] ];
        [ self reset ];
    }
    return self;
}

- ( bool ) hasWon {
    NSMutableArray *array = [ [ NSMutableArray alloc ] initWithCapacity: 4 ];
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
        
        [ array removeAllObjects ];
    }
    
    return true;
}

@end



