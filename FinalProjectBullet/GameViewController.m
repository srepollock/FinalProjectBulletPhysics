//
//  ViewController.m
//  BulletTest
//
//  Created by Borna Noureddin on 2015-03-20.
//  Copyright (c) 2015 BCIT. All rights reserved.
//

#import "GameViewController.h"
#import "BulletPhysics.h"
#import "BulletPhysics.h"

@interface GameViewController ()
{
    BulletPhysics *bp;
}

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    bp = [[BulletPhysics alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)update
{
    if (!bp) return;
    [bp Update:self.timeSinceLastUpdate];
}

@end
