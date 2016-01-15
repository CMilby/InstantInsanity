//
//  SquareGameScene.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/13/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "SquareGameScene.h"

#include "Constants.h"

@implementation SquareGameScene {
    
}

- ( id ) initWithView: ( GLKView* ) view withShaders: ( NSMutableArray<Shader*>* ) shaders withCamera: ( Camera* ) camera {
    if ( self = [ super initWithView: view withShaders: shaders withCamera: camera ] ) {
        Cube *cube1 = [ [ Cube alloc ] init: @"Square_Cube_1" ];
        [ [ cube1 transform ] setPosition: GLKVector3Make( -1.5f, 0.0f, -1.5f ) ];
        [ cube1 setCode: 1 ];
        [ cube1 setFrontColor: ORANGE_COLOR ];
        [ cube1 setBackColor: BLUE_COLOR ];
        [ cube1 setLeftColor: RED_COLOR ];
        [ cube1 setRightColor: RED_COLOR ];
        [ cube1 setTopColor: ORANGE_COLOR ];
        [ cube1 setBottomColor: GREEN_COLOR ];
        
        Cube *cube2 = [ [ Cube alloc ] init: @"Square_Cube_2" ];
        [ [ cube2 transform ] setPosition: GLKVector3Make( 1.5f, 0.0f, 1.5f ) ];
        [ cube2 setCode: 2 ];
        [ cube2 setFrontColor: BLUE_COLOR ];
        [ cube2 setBackColor: GREEN_COLOR ];
        [ cube2 setLeftColor: GREEN_COLOR ];
        [ cube2 setRightColor: ORANGE_COLOR ];
        [ cube2 setTopColor: ORANGE_COLOR ];
        [ cube2 setBottomColor: GREEN_COLOR ];
        
        Cube *cube3 = [ [ Cube alloc ] init: @"Square_Cube_3" ];
        [ [ cube3 transform ] setPosition: GLKVector3Make( -1.5f, 0.0f, 1.5f ) ];
        [ cube3 setCode: 3 ];
        [ cube3 setFrontColor: RED_COLOR ];
        [ cube3 setBackColor: RED_COLOR ];
        [ cube3 setLeftColor: BLUE_COLOR ];
        [ cube3 setRightColor: BLUE_COLOR ];
        [ cube3 setTopColor: GREEN_COLOR ];
        [ cube3 setBottomColor: ORANGE_COLOR ];
        
        Cube *cube4 = [ [ Cube alloc ] init: @"Square_Cube_4" ];
        [ [ cube4 transform ] setPosition: GLKVector3Make( 1.5f, 0.0f, -1.5f ) ];
        [ cube4 setCode: 4 ];
        [ cube4 setFrontColor: ORANGE_COLOR ];
        [ cube4 setBackColor: GREEN_COLOR ];
        [ cube4 setLeftColor: GREEN_COLOR ];
        [ cube4 setRightColor: ORANGE_COLOR ];
        [ cube4 setTopColor: RED_COLOR ];
        [ cube4 setBottomColor: GREEN_COLOR ];
        
        m_cubes = [ [ NSMutableArray alloc ] initWithCapacity: 4 ];
        [ m_cubes addObject: cube1 ];
        [ m_cubes addObject: cube2 ];
        [ m_cubes addObject: cube3 ];
        [ m_cubes addObject: cube4 ];
        
        [ m_winMenu setTexture: [ [ Texture alloc ] init: @"WinScreenSquare" ] ];
        [ self reset ];
    }
    return self;
}

- ( bool ) hasWon {
    if ( [ m_cubes[ 2 ] frontColor ] != [ m_cubes[ 1 ] frontColor ] ) {
        return false;
    }
    
    if ( [ m_cubes[ 2 ] leftColor ] != [ m_cubes[ 0 ] leftColor ] ) {
        return false;
    }
    
    if ( [ m_cubes[ 1 ] rightColor ] != [ m_cubes[ 3 ] rightColor ] ) {
        return false;
    }
    
    if ( [ m_cubes[ 0 ] backColor ] != [ m_cubes[ 3 ] backColor ] ) {
        return false;
    }
    
    if ( [ m_cubes[ 0 ] bottomColor ] != [ m_cubes[ 1 ] bottomColor ] || [ m_cubes[ 1 ] bottomColor ] != [ m_cubes[ 2 ] bottomColor ] || [ m_cubes[ 2 ] bottomColor ] != [ m_cubes[ 3 ] bottomColor ] ) {
       return false;
    }
    
    if ( [ m_cubes[ 0 ] topColor ] != [ m_cubes[ 1 ] topColor ] || [ m_cubes[ 1 ] topColor ] != [ m_cubes[ 2 ] topColor ] || [ m_cubes[ 2 ] topColor ] != [ m_cubes[ 3 ] topColor ] ) {
        return false;
    }
    
    return true;
}

@end