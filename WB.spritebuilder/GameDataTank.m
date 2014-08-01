//
//  GameDataTank.m
//  WB
//
//  Created by Jonathan Alcontin on 7/31/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameDataTank.h"

@implementation GameDataTank


//static variable - this stores our singleton instance
static GameDataTank *sharedData = nil;

+(GameDataTank*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        //create our singleton instance
        sharedData = [[GameDataTank alloc] init];
        
        NSNumber *tanks = [[NSUserDefaults standardUserDefaults]objectForKey:@"boughtTanks"];
        sharedData.tanks = [tanks integerValue];
        
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

- (void)setTanks:(NSInteger)tanks {
    _tanks = tanks;
    
    NSNumber *tankNumber = [NSNumber numberWithInteger:tanks];
    
    // store change
    [[NSUserDefaults standardUserDefaults]setObject:tankNumber forKey:@"boughtTanks"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //finished setting up tank singleton gamedata
}


@end
