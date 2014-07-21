//
//  Store.m
//  WB
//
//  Created by Jonathan Alcontin on 7/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Store.h"

@implementation Store


- (void)home {
    CCLOG(@"store close, back to gameplay");
    [[CCDirector sharedDirector] popScene];
}


@end
