/*
 * cocos2d for iPhone: http://www.cocos2d-iphone.org
 *
 * Copyright (c) 2010 Ricardo Quesada
 * Copyright (c) 2011 Zynga Inc.
 * Copyright (c) 2013-2014 Cocos2D Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

//
// Common layer for OpenGL stuff
//

#import "../ccMacros.h"

#if __CC_PLATFORM_IOS
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLES/EAGL.h>
#import "iOS/CCGLView.h"

#elif __CC_PLATFORM_MAC
#import <OpenGL/gl.h>
#import <OpenGL/glu.h>
#import <Cocoa/Cocoa.h>	// needed for NSOpenGLView
#import "Mac/CCGLView.h"
#endif

#if DEBUG
#define CC_CHECK_GL_ERROR_DEBUG() __CC_CHECK_GL_ERROR_DEBUG(__FUNCTION__, __LINE__)
static inline void __CC_CHECK_GL_ERROR_DEBUG(const char *function, int line)
{
	GLenum error;
	while((error = glGetError())){
		switch(error){
			case GL_INVALID_ENUM: printf("OpenGL error GL_INVALID_ENUM detected at %s %d\n", function, line); break;
			case GL_INVALID_VALUE: printf("OpenGL error GL_INVALID_VALUE detected at %s %d\n", function, line); break;
			case GL_INVALID_OPERATION: printf("OpenGL error GL_INVALID_OPERATION detected at %s %d\n", function, line); break;
			case GL_INVALID_FRAMEBUFFER_OPERATION: printf("OpenGL error GL_INVALID_FRAMEBUFFER_OPERATION detected at %s %d\n", function, line); break;
			default: printf("OpenGL error 0x%04X detected at %s %d\n", error, function, line);
		}
	}
}
#else
#define CC_CHECK_GL_ERROR_DEBUG()
#endif

// iOS
#if __CC_PLATFORM_IOS
#define	glClearDepth				glClearDepthf
#define glDeleteVertexArrays		glDeleteVertexArraysOES
#define glGenVertexArrays			glGenVertexArraysOES
#define glBindVertexArray			glBindVertexArrayOES
#define glMapBuffer					glMapBufferOES
#define glUnmapBuffer				glUnmapBufferOES

#undef GL_DEPTH24_STENCIL8
#define GL_DEPTH24_STENCIL8			GL_DEPTH24_STENCIL8_OES
#define GL_WRITE_ONLY				GL_WRITE_ONLY_OES

// Mac
#elif __CC_PLATFORM_MAC


#if 1
#define glDeleteVertexArrays		glDeleteVertexArraysAPPLE
#define glGenVertexArrays			glGenVertexArraysAPPLE
#define glBindVertexArray			glBindVertexArrayAPPLE

#else // OpenGL 3.2 Core Profile

#define glDeleteVertexArrays		glDeleteVertexArrays
#define glGenVertexArrays			glGenVertexArrays
#define glBindVertexArray			glBindVertexArray
#endif

#endif
