//
//  BulletPhysics.h
//  BulletTest
//
//  Created by Borna Noureddin on 2015-03-20.
//  Copyright (c) 2015 BCIT. All rights reserved.
//

#import <Foundation/Foundation.h>

struct Vector3 {
    float x, y, z;
} vec3;

@interface BulletPhysics: NSObject {
    @public
    struct Vector3 ballPos;
    struct Vector3 floorPos;
}

-(void)Update:(float)elapsedTime;

@end
