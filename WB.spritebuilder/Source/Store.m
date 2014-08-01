//
//  Store.m
//  WB
//
//  Created by Jonathan Alcontin on 7/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Store.h"
#import "GameDataCoin.h"
#import "GameDataTank.h"
#import "Gameplay.h"

@implementation Store {
    
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_scoreLabelRobot;
    
    CCLabelTTF *_dialogue;
}

-(void) didLoadFromCCB {
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    
    
    _dialogue.string = [NSString stringWithFormat:@"Hey"];
    
}

                        
- (void)buyTank {
    
    CCLOG(@"buy tank button pressed");
    // position the tank near the front of the gun of mecha
    
    
    [GameDataCoin sharedData].coins -= 1;
    
    [GameDataTank sharedData].tanks += 1;
    
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    _scoreLabelRobot.string = [NSString stringWithFormat:@"%ld", (long)[GameDataTank sharedData].tanks];
    CCLOG(@"bought tank for 1 gold");
}

- (void)dialogue {
    CCLOG(@"button pressed dialogue");
//    
// if (_dialogue.string = [NSString stringWithFormat:@"Hey"];) {
//    
//   _dialogue.string = [NSString stringWithFormat:@"Hello"];
//    
//} if (_life <= 25) {
//    
//    [[_wall animationManager] runAnimationsForSequenceNamed: @"25Wall"];
//    CCLOG(@"HP hit 25");}
////
//
}
- (void)home {
    CCLOG(@"store close, back to gameplay");
    [[CCDirector sharedDirector] popScene];
    

    
    
}




@end
