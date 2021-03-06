//
//  OverlaySelectionShader.vsh
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

attribute vec2 position;
attribute vec2 texCoord;

void main()
{
    highp vec2 vertexPos = position - vec2( 400, 300 );
    vertexPos /= vec2( 400, 300 );
    gl_Position = vec4( vertexPos, 0, 1 );
}