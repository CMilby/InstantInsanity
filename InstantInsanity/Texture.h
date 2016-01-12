//
//  Texture.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __TEXTURE_H__
#define __TEXTURE_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@interface Texture : NSObject {
    GLuint m_texture;
}

- ( id ) init: ( NSString* ) filename;

- ( void ) cleanup;

- ( void ) bind;

@end

#endif /* Texture_h */
