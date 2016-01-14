//
//  OverlayShader.fsh
//  InstantInsanity
//
//  Created by Craig Milby on 1/14/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

varying lowp vec2 texCoord0;

uniform sampler2D sampler;

void main()
{
    gl_FragColor = texture2D( sampler, texCoord0.st );
}

