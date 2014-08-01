//
//  Gameplay.m
//  WB
//
//  Created by Jonathan Alcontin on 7/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Bullet.h"
#import "Wall.h"
#import "GameDataCoin.h"
#import "Store.h"
#import "Mechshoot.h"
#import "FinishButton.h"
#import "Tank.h"
#import "GameDataTank.h"

@implementation Gameplay {
    //Spritebuilder Nodes
    CCPhysicsNode *_physicsNode;
    CCNode *_mech1;
    CCNode *_levelNode;
    CCNode *_health;
    CCLabelTTF *_scoreLabel;
   
    //object instances
    Tank *_tank;
    FinishButton *_finishButton;
    Wall *_wall;
    Mechshoot *_mech2;
    
    //life of the wall
    float _life;
    
    //array
    
}

//----------------------------------------------------------------------------------
#pragma mark CCBLoad
- (void)didLoadFromCCB {
    
    //loads mecha with timelines
    _mech2 = (Mechshoot *) [CCBReader load:@"mech2" owner:self];
    _mech2.position = ccp(35, 68.1);
    [self addChild: _mech2];
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCNode *level = [CCBReader load:@"Levels/Level1" owner:self];

    [_levelNode addChild:level];
    _physicsNode.collisionDelegate = self;
    _life = 100;
    
    //set the _scoreLabel string to the number of coins
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    
}

//----------------------------------------------------------------------------------
#pragma mark touch

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
//    [self launchbullet]; is called when this animation is called?
    [[_mech2 animationManager] runAnimationsForSequenceNamed: @"Shoot time"];
    
}

//----------------------------------------------------------------------------------
#pragma mark bullets
- (void)launchBullet {
    
    //calling launchBullet method is also used as a selector in Spritebuilder in Mech2.ccb to call "Shoot time"
    
    CCParticleSystem *gunshotbutt = (CCParticleSystem *)[CCBReader load:@"gunbutt"];
    gunshotbutt.autoRemoveOnFinish = TRUE;
    gunshotbutt.position = ccpAdd(_mech2.position, ccp(95, 53));
    [self addChild:gunshotbutt];
    
    // loads the bullet.ccb we have set up in Spritebuilder
    Bullet* bullet = (Bullet*)[CCBReader load:@"bullet"];
    
    // position the bullets at the front of the gun of mecha
    bullet.position = ccpAdd(_mech2.position, ccp(95, 53));
    
    // add the bullet to the physicsNode of this scene (because it has physics enabled)
    [_physicsNode addChild:bullet];
  
    //manually create & apply a force to launch the bullet
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 7000);
    [bullet.physicsBody applyForce:force];
    
    
    

}
//----------------------------------------------------------------------------------
#pragma mark wall

-(void) hit:(CCNode*)wall {
    if(_life > 0) {
        
        _life -= 3;
        _health.scaleX = _life/100 ;
        //set damage done as coins/score gained
        
    } if (_life <= 75) {
        
        [[_wall animationManager] runAnimationsForSequenceNamed: @"75Wall"];
        CCLOG(@"HP hit 75");
        
    } if (_life <= 50) {
        
        //have wall crumble animation, also input different wall sprites at middle and critical health states;
        
        [[_wall animationManager] runAnimationsForSequenceNamed: @"50Wall"];
        CCLOG(@"HP hit 50");
        
    } if (_life <= 25) {
        
        [[_wall animationManager] runAnimationsForSequenceNamed: @"25Wall"];
        CCLOG(@"HP hit 25");
        
    } // --- end code for wall change sprite here
    if (_life <= 0) {
        
        _health.scale = 0;
        _life = 0;
        
        _finishButton = (FinishButton *) [CCBReader load:@"finishButton" owner:self];
        _finishButton.position = ccp(300, 150);
        [self addChild: _finishButton];
        
        [[CCDirector sharedDirector] pause];
        
        
        //why does it take so long to do the finishing move? Can we polish this to make this smoother so the action happens.
        //[self win]; have robot do a finishing animation that will collide with the wall that will remove the wall and create another wall blow up animation.
        //[wall removeFromParent];
        
        //have wall crumble animation, also input different wall sprites at middle and critical health states;
        
        //if there is no wall summon a new wall with stronger stats, or load a new level.
    }
}

//----------------------------------------------------------------------------------
#pragma mark physics

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    
    // collision handling
    [self hit:wall];
    
    [GameDataCoin sharedData].coins += ((Bullet*)bullet).myCustomIsaac;
    //i want to pull the value from the custom property myCustomIsaac set in bulle+ armyunit.value,
    //I probably want the damage to incrementally get stronger each time an army unit is purchased
    //and change the default sprite based on how large this integer becomes
    
    [bullet removeFromParent];
    CCLOG(@"Bullet hit the wall finnally!");
    
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    
    //particles that appear when bullet hits wall
    CCParticleSystem *bluewallhit = (CCParticleSystem *)[CCBReader load:@"gunshot"];
    
    bluewallhit.autoRemoveOnFinish = TRUE;
    bluewallhit.position = ccpAdd(_wall.position, ccp(450, 125));
    
    [self addChild:bluewallhit];
    
}


- (void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    // collision handling, set a collision animation to occur after bullet hits.
    CCLOG(@"GOLD SWEET GOLD");
    
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    
}

//----------------------------------------------------------------------------------
#pragma mark buttons

- (void) finishButton {
    CCLOG(@"finish button pressed");
    [[CCDirector sharedDirector] resume];
    
    
    // [[_wall animationManager] runAnimationsForSequenceNamed: @"DisintegrateWall"];
    /* add disintegrating animation wall */
    [[_mech2 animationManager] runAnimationsForSequenceNamed: @"finish1" ];
     self.userInteractionEnabled = NO;
    [self runAction:[CCActionSequence actionOne:[CCActionDelay actionWithDuration:3.f] two:[CCActionCallBlock actionWithBlock:^{
        [[_mech2 animationManager] runAnimationsForSequenceNamed:@"what time"];
        self.userInteractionEnabled = YES;
    }]]];
   
    
    
    
    //try to have this loop for a few seconds (this can be set up in spritebuilder) then load to a new animation. "Set up" animation -> finish1 ->"settle down" animation
    
    // is this needed? I want to have the setup and settle down animations occur to run once, while finish1 animation will run for like 2-3
    //setupanimationfinish1.autoRemoveOnFinish = TRUE;
    //finish1.autoRemoveOnFinish = TRUE;
    //settledownanimationfinish1.autoRemoveOnFinish = TRUE;

    [_wall removeFromParent];
    [_finishButton setVisible:NO];
    
   
   //have wall animate disintegration animation to play while @"finish1" animation playing, second after this animation is done call resetGame
    
    
    
    
//    CCScene *storeScene = [CCBReader loadAsScene:@"Store"];
//    // [[CCDirector sharedDirector] popScene];
//    CCTransition *transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:1.f];
//    [[CCDirector sharedDirector] pushScene:storeScene withTransition:transition];

}

- (void) store {
    
    CCLOG(@"coin button pressed");
    
    //Load the store
    CCScene *storeScene = [CCBReader loadAsScene:@"store" owner:self];
    
    // [[CCDirector sharedDirector] popScene]; this will remove a scene
    
    //use the fancy transition stuffz
    CCTransition *transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:1.f];
    [[CCDirector sharedDirector] pushScene:storeScene withTransition:transition];

}

//SET UP CODE FOR PLACING TANK ON GAMEPLAY SCENE.
//have

- (void)buyTank {
    
    CCLOG(@"buy tank button pressed");
    // position the tank near the front of the gun of mecha
    

    [GameDataCoin sharedData].coins -= 1;
    
    [GameDataTank sharedData].tanks += 1;
    
    _scoreLabel.string = [NSString stringWithFormat:@"%ld", (long)[GameDataCoin sharedData].coins];
    CCLOG(@"bought tank for 50 gold");
    
}

//----------------------------------------------------------------------------------
#pragma mark debugging stuff

- (void)resetGame{
    // quick button to reset game for play testing
    CCNode *level = [CCBReader load:@"Levels/Level1" owner:self];
    
    [_levelNode addChild:level];
    _life = 100;
}

//----------------------------------------------------------------------------------
#pragma mark unused code

/*
 - (void)win {
 [self endGameWithMessage:@"You win!"];
 [self respawnWall]; fix this tonight
 
 }
 
 - (void)endGameWithMessage:(NSString*)message {
 CCLOG(@"%@",message);
 
 }
 
- (void)respawnWall {
    Wall* wall = (Wall*)[CCBReader load:@"wall"];
//    wall.position = cpAdd(_levelNode.position, ccp(0,0));
    
    //respawn the wall after winning last level.
}

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
 
 [[_mech2 animationManager] runAnimationsForSequenceNamed: @"what time"];
 use this as a base to create a laser charge animation
 
}


*/
@end
