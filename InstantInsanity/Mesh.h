//
//  Mesh.h
//  InstantInsanity
//
//  Created by Craig Milby on 1/7/16.
//  Copyright © 2016 Craig Milby. All rights reserved.
//

#ifndef __MESH_H__
#define __MESH_H__

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGLES/ES2/glext.h>

@interface Mesh : NSObject {
    GLuint m_vertexBuffer;
    GLuint m_uvBuffer;
    GLuint m_normalBuffer;
    
    unsigned int m_size;
}

- ( id ) init;

- ( id ) init: ( const GLfloat[] ) vertices withVertexSize: ( GLuint ) vertexSize withUVs: ( const GLfloat[] ) uvs withUVSize: ( GLuint ) uvSize withNormals: ( const GLfloat[] ) normals withNormalSize: ( GLuint ) normalSize;

- ( void ) cleanup;

- ( void ) render;

@end

#endif /* Mesh_h */
