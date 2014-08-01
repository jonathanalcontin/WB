//
//  GameDataCoin.h
//  WB
//
//  Created by Jonathan Alcontin on 7/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

//#import <Foundation/Foundation.h> //why does it have to import foundation?

@interface GameDataCoin : NSObject



//the keyword "nonatomic" is a property declaration
//nonatomic properties have better performance than atomic properties (so use them!)
//@property (nonatomic) NSMutableArray* arrayOfDataToBeStored;
@property (nonatomic) NSInteger coins;


//Static (class) method:
+(GameDataCoin*) sharedData;

//create a singleton that will be accessible from gameplay scene (gain gold coins from doing damage) and store scene(purchase mercenaries/upgrades)
@end


