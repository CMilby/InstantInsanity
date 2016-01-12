//
//  SelectionShader.fsh
//  InstantInsanity
//
//  Created by Craig Milby on 1/10/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

uniform highp float code;

void main()
{
    lowp vec3 color = vec3( code / 255.0 );
    gl_FragColor = vec4( color, 1.0 );
}