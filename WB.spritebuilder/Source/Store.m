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
    
    
    //scores
    CCLabelTTF *_scoreLabel;
    CCLabelTTF *_scoreLabelRobot;
    
    //dialogue stuff
    CCLabelTTF *_dialogue;
    NSMutableArray *_gridArray;
    
    NSInteger i;

}

-(void) didLoadFromCCB {
    
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    
    _scoreLabelRobot.string = [NSString stringWithFormat:@"%ld", (long)[GameDataTank sharedData].tanks];
    
    _dialogue.string = [NSString stringWithFormat:@"Hey"];
    
    i = 0;
    
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

    i++;
    
    [self whereInDialogue: i ];
    

}


- (void) whereInDialogue : (int) i {
    switch (i) {
        case 1: _dialogue.string = [NSString stringWithFormat:@"Hello"];
            break;
        case 2: _dialogue.string = [NSString stringWithFormat:@"Lets be close friends"];
            break;
        case 3: _dialogue.string = [NSString stringWithFormat:@"Nah."];
            break;
        case 4: _dialogue.string = [NSString stringWithFormat:@"..."];
            break;
        case 5: _dialogue.string = [NSString stringWithFormat:@"..."];
            break;
        case 6: _dialogue.string = [NSString stringWithFormat:@"Just kidding <3 , sure"];
            break;
        case 7: _dialogue.string = [NSString stringWithFormat:@"..."];
            break;
       
            
}
    
}

- (void)home {
    CCLOG(@"store close, back to gameplay");
    [[CCDirector sharedDirector] popScene];
    

    
    
}




@end
