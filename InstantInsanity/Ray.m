//
//  Ray.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/10/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Ray.h"

@implementation Ray {
    
}

- ( id ) init {
    if ( self = [ super init ] ) {
        m_origin = GLKVector3Make( 0.0f, 0.0f, 0.0f );
        m_direction = GLKVector3Make( 0.0f, 0.0f, 1.0f );
    }
    return self;
}

- ( id ) init: ( GLKVector3 ) origin inDirection: ( GLKVector3 ) direction {
    if ( self = [ super init ] ) {
        m_origin = origin;
        m_direction = direction;
    }
    return self;
}

- ( GLKVector3 ) getDirection {
    return m_direction;
}

- ( GLKVector3 ) getOrigin {
    return m_origin;
}

@end