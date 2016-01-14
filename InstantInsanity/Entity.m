//
//  Entity.m
//  InstantInsanity
//
//  Created by Craig Milby on 1/9/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#include "Entity.h"

#include "Camera.h"

@implementation Entity {
    
}

- ( id ) init {
    if ( self = [ super init ] ) {
        m_children = [ [ NSMutableArray alloc ] init ];
        m_transform = [ [ Transform alloc ] init ];
        m_isPicked = false;
    }
    return self;
}

- ( id ) init: ( Transform* ) transform {
    if ( self = [ super init ] ) {
        m_children = [ [ NSMutableArray alloc ] init ];
        m_transform = transform;
        m_isPicked = false;
    }
    return self;
}

- ( void ) cleanup {
    
}

- ( void ) cleanupAll {
    [ self cleanup ];
    for ( int i = 0; i < [ m_children count ]; i++ ) {
        [ [ m_children objectAtIndex: i ] cleanupAll ];
    }
}

- ( Entity* ) addChild: ( Entity* ) child {
    [ m_children addObject: child ];
    return self;
}

- ( void ) update {
    
}

- ( void ) updateAll {
    [ self update ];
    for ( int i = 0; i < [ m_children count ]; i++ ) {
        [ [ m_children objectAtIndex: i ] updateAll ];
    }
}

- ( void ) render {
    
}

- ( void ) renderAll {
    [ self render ];
    for ( int i = 0; i < [ m_children count ]; i++ ) {
        [ [ m_children objectAtIndex: i ] renderAll ];
    }
}

- ( Transform* ) transform {
    return m_transform;
}

- ( void ) setTransform: ( Transform* ) transform {
    m_transform = transform;
}

- ( bool ) isPicked {
    return m_isPicked;
}

- ( void ) setIsPicked: ( bool ) value {
    m_isPicked = value;
}

@end