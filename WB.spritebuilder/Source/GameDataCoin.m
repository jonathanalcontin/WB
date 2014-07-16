//
//  GameDataCoin.m
//  WB
//
//  Created by Jonathan Alcontin on 7/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameDataCoin.h" //Question : How can I tie the damage done = coins gained, to be 


@implementation GameDataCoin

//static variable - this stores our singleton instance
static GameDataCoin *sharedData = nil;

+(GameDataCoin*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[GameDataCoin alloc] init];
        
        NSNumber *coins = [[NSUserDefaults standardUserDefaults]objectForKey:@"savedCoins"];
        sharedData.coins = [coins integerValue];
        
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

- (void)setCoins:(NSInteger)coins {
    _coins = coins;
    
    NSNumber *coinNumber = [NSNumber numberWithInt:coins];
    
    // store change
    [[NSUserDefaults standardUserDefaults]setObject:coinNumber forKey:@"savedCoins"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end