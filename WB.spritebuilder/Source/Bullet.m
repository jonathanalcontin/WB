//
//  bullet.m
//  WB
//
//  Created by Jonathan Alcontin on 7/11/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet


- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"bullet";
}

@end
