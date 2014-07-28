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

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_mech1;
    Mechshoot *_mech2;
    CCNode *_levelNode;
    CCNode *_health;
    CCLabelTTF *_scoreLabel;

    float _life;
}
// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    
    
    //loads mecha with timelines
    _mech2 = (Mechshoot *) [CCBReader load:@"mech2" owner:self];
    _mech2.position = ccp(35, 68.1);
    [self addChild: _mech2];
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCNode *level = [CCBReader load:@"Levels/Level1"];
    [_levelNode addChild:level];
    _physicsNode.collisionDelegate = self;
    _life = 100;
    
    
    
}

// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
//    [self launchbullet];
    [[_mech2 animationManager] runAnimationsForSequenceNamed: @"Shoot time"];
}

//- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
//    
//    [[_mech2 animationManager] runAnimationsForSequenceNamed: @"what time"];
//    use this as a base to create a laser charge animation
//    
//}

- (void)launchBullet {
 
    //calling launchBullet method is also used as a selector in Spritebuilder in Mech2.ccb to call "Shoot time"
    
    //---------------------bullet code ------------------
    
   // loads the bullet.ccb we have set up in Spritebuilder
   Bullet* bullet = (Bullet*)[CCBReader load:@"bullet"];
    // position the bullets at the front of the gun of mecha
   bullet.position = ccpAdd(_mech2.position, ccp(100, 65));
// add the bullet to the physicsNode of this scene (because it has physics enabled)

    
    
     [_physicsNode addChild:bullet];
  
//manually create & apply a force to launch the bullet
 CGPoint launchDirection = ccp(1, 0);
  CGPoint force = ccpMult(launchDirection, 7000);
  [bullet.physicsBody applyForce:force];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    // collision handling
    [self hit:wall];
    [GameDataCoin sharedData].coins += ((Bullet*)bullet).myCustomIsaac; //(i want to pull the value from the custom property myCustomIsaac set in bullet)+ armyunit.value, I probably want the damage to incrementally get stronger each time an army unit is purchased (and change the default sprite based on how large this integer becomes;
    [bullet removeFromParent];
    CCLOG(@"Bullet hit the wall finnally!");
    
    _scoreLabel.string = [NSString stringWithFormat:@"%d", [GameDataCoin sharedData].coins];
}



- (void)ccPhysicsCollisionSeparate:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    // collision handling, set a collision animation to occur after bullet hits.
        CCLOG(@"GOLD SWEET GOLD");
    
    _scoreLabel.string = [NSString stringWithFormat:@"%d", [GameDataCoin sharedData].coins];
}




- (void)win {
    [self endGameWithMessage:@"You win!"];
//    [self respawnWall]; fix this tonight
    //
    
}
- (void)endGameWithMessage:(NSString*)message {
    CCLOG(@"%@",message);
    
 
}


-(void) hit:(CCNode*)wall {
        if(_life > 0)
        {
            _life -= 3;
            _health.scaleX = _life/100 ;
            //set damage done as coins/score gained
        }
        if (_life <= 0) {
            _health.scale = 0;
            _life = 0;
//            [self win]; have robot do a finishing animation that will collide with the wall that will remove the wall and create another wall blow up animation.
            [wall removeFromParent];
            
            //have wall crumble animation, also input different wall sprites at middle and critical health states;
        }
    }

- (void)store {
    CCLOG(@"coin button pressed");
    CCScene *storeScene = [CCBReader loadAsScene:@"Store"];
    // [[CCDirector sharedDirector] popScene];
       CCTransition *transition = [CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:1.f];
       [[CCDirector sharedDirector] pushScene:storeScene withTransition:transition];
}


//
//- (void)respawnWall {
//    Wall* wall = (Wall*)[CCBReader load:@"wall"];
////    wall.position = cpAdd(_levelNode.position, ccp(0,0));
//    
//    //respawn the wall after winning last level.
//}
@end
