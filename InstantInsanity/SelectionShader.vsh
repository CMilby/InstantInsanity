//
//  SelectionShader.vsh
//  InstantInsanity
//
//  Created by Craig Milby on 1/10/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

attribute vec3 position;

uniform mat4 mvp;

void main()
{
    gl_Position = mvp * vec4( position, 1.0 );
}