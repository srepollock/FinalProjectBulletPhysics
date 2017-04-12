//
//  Shader.fsh
//  FinalProjectBullet
//
//  Created by Spencer Pollock on 2017-04-12.
//  Copyright © 2017 Spencer Pollock. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
