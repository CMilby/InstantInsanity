//
//  ClassicOneGameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "ClassicOneGameScene.h"

#include "Constants.h"

@implementation ClassicOneGameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        Cube *cube1 = [ [ Cube alloc ] init: @"Classic_Cube_1" ];
        [ [ cube1 transform ] setPosition: GLKVector3Make( 0.0, -4.5f, 0.0 ) ];
        [ cube1 setCode: 1 ];
        [ cube1 setFrontColor: RED_COLOR ];
        [ cube1 setBackColor: RED_COLOR ];
        [ cube1 setLeftColor: RED_COLOR ];
        [ cube1 setRightColor: GREEN_COLOR ];
        [ cube1 setTopColor: YELLOW_COLOR ];
        [ cube1 setBottomColor: BLUE_COLOR ];
        
        Cube *cube2 = [ [ Cube alloc ] init: @"Classic_Cube_2" ];
        [ [ cube2 transform ] setPosition: GLKVector3Make( 0.0, -1.5f, 0.0 ) ];
        [ cube2 setCode: 2 ];
        [ cube2 setFrontColor: YELLOW_COLOR ];
        [ cube2 setBackColor: RED_COLOR ];
        [ cube2 setLeftColor: RED_COLOR ];
        [ cube2 setRightColor: BLUE_COLOR ];
        [ cube2 setTopColor: YELLOW_COLOR ];
        [ cube2 setBottomColor: GREEN_COLOR ];
        
        Cube *cube3 = [ [ Cube alloc ] init: @"Classic_Cube_3" ];
        [ [ cube3 transform ] setPosition: GLKVector3Make( 0.0, 1.5f, 0.0 ) ];
        [ cube3 setCode: 3 ];
        [ cube3 setFrontColor: GREEN_COLOR ];
        [ cube3 setBackColor: GREEN_COLOR ];
        [ cube3 setLeftColor: BLUE_COLOR ];
        [ cube3 setRightColor: RED_COLOR ];
        [ cube3 setTopColor: BLUE_COLOR];
        [ cube3 setBottomColor: YELLOW_COLOR ];
        
        Cube *cube4 = [ [ Cube alloc ] init: @"Classic_Cube_4" ];
        [ [ cube4 transform ] setPosition: GLKVector3Make( 0.0, 4.5f, 0.0 ) ];
        [ cube4 setCode: 4 ];
        [ cube4 setFrontColor: YELLOW_COLOR ];
        [ cube4 setBackColor: BLUE_COLOR ];
        [ cube4 setLeftColor: GREEN_COLOR ];
        [ cube4 setRightColor: RED_COLOR ];
        [ cube4 setTopColor: YELLOW_COLOR ];
        [ cube4 setBottomColor: GREEN_COLOR ];
        
        m_cubes = [ [ NSMutableArray alloc ] initWithCapacity: 4 ];
        [ m_cubes addObject: cube1 ];
        [ m_cubes addObject: cube2 ];
        [ m_cubes addObject: cube3 ];
        [ m_cubes addObject: cube4 ];
    }
    return self;
}

- ( bool ) hasWon {
    NSMutableArray *array = [ [ NSMutableArray alloc ] initWithCapacity: 3 ];
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
        
        [ array removeAllObjects ];
    }
    
    return true;
}

@end