//
//  ClocksGameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "ClocksGameScene.h"

#include "Constants.h"

@implementation ClocksGameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        Cube *cube1 = [ [ Cube alloc ] init: @"Clocks_Cube_1" ];
        [ [ cube1 transform ] setPosition: GLKVector3Make( 0.0f, -4.5f, 0.0f ) ];
        [ cube1 setCode: 1 ];
        [ cube1 setFrontColor: CLOCK_2 ];
        [ cube1 setBackColor: CLOCK_2 ];
        [ cube1 setLeftColor: CLOCK_2 ];
        [ cube1 setRightColor: CLOCK_8 ];
        [ cube1 setTopColor: CLOCK_4 ];
        [ cube1 setBottomColor: CLOCK_10 ];
        
        Cube *cube2 = [ [ Cube alloc ] init: @"Clocks_Cube_2" ];
        [ [ cube2 transform ] setPosition: GLKVector3Make( 0.0f, -1.5f, 0.0f ) ];
        [ cube2 setCode: 2 ];
        [ cube2 setFrontColor: CLOCK_4 ];
        [ cube2 setBackColor: CLOCK_2 ];
        [ cube2 setLeftColor: CLOCK_2 ];
        [ cube2 setRightColor: CLOCK_10 ];
        [ cube2 setTopColor: CLOCK_4 ];
        [ cube2 setBottomColor: CLOCK_8 ];
        
        Cube *cube3 = [ [ Cube alloc ] init: @"Clocks_Cube_3" ];
        [ [ cube3 transform ] setPosition: GLKVector3Make( 0.0f, 1.5f, 0.0f ) ];
        [ cube3 setCode: 3 ];
        [ cube3 setFrontColor: CLOCK_8 ];
        [ cube3 setBackColor: CLOCK_8 ];
        [ cube3 setLeftColor: CLOCK_10 ];
        [ cube3 setRightColor: CLOCK_2 ];
        [ cube3 setTopColor: CLOCK_10 ];
        [ cube3 setBottomColor: CLOCK_4 ];
        
        Cube *cube4 = [ [ Cube alloc ] init: @"Clocks_Cube_4" ];
        [ [ cube4 transform ] setPosition: GLKVector3Make( 0.0f, 4.5f, 0.0f ) ];
        [ cube4 setCode: 4 ];
        [ cube4 setFrontColor: CLOCK_4 ];
        [ cube4 setBackColor: CLOCK_10 ];
        [ cube4 setLeftColor: CLOCK_8 ];
        [ cube4 setRightColor: CLOCK_2 ];
        [ cube4 setTopColor: CLOCK_4 ];
        [ cube4 setBottomColor: CLOCK_8 ];
        
        m_cubes = [ [ NSMutableArray alloc ] initWithCapacity: 4 ];
        [ m_cubes addObject: cube1 ];
        [ m_cubes addObject: cube2 ];
        [ m_cubes addObject: cube3 ];
        [ m_cubes addObject: cube4 ];
    }
    return self;
}

- ( bool ) hasWon {
    int total;
    for ( int i = 0; i < 4; i++ ) {
        total = 0;
        total += [ m_cubes[ 0 ] color: i ];
        total += [ m_cubes[ 1 ] color: i ];
        total += [ m_cubes[ 2 ] color: i ];
        total += [ m_cubes[ 3 ] color: i ];
        
        if ( total != 24 ) {
            return false;
        }
    }
    return true;
}

@end







