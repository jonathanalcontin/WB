//
//  GameDataTank.h
//  WB
//
//  Created by Jonathan Alcontin on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDataTank : NSObject

@property (nonatomic) NSInteger tanks;


//Static (class) method:
+(GameDataTank*) sharedData;

//create a singleton that will be accessible from gameplay scene (gain gold coins from doing damage) and store scene(purchase mercenaries/upgrades)


@end
