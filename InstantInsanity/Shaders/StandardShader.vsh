//
//  StandardShader.vsh
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

attribute vec3 position;
attribute vec2 texCoord;
attribute vec3 normal;

varying lowp vec2 texCoord0;

uniform mat4 mvp;

void main()
{
    texCoord0 = texCoord;
    gl_Position = mvp * vec4( position, 1.0 );
}
