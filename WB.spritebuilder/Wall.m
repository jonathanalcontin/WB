//
//  Wall.m
//  WB
//
//  Created by Jonathan Alcontin on 7/14/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Wall.h"

@implementation Wall


- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"wall";
}

@end
