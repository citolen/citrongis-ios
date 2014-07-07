//
//  Shader.fsh
//  testGl
//
//  Created by Charly DELAROCHE on 23/06/14.
//  Copyright (c) 2014 Charly DELAROCHE. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
