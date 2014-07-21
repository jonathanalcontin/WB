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

@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_mech1;
    CCNode *_levelNode;
    CCNode *_health;
    CCLabelTTF *_scoreLabel;

    float _life;
}
// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCNode *level = [CCBReader load:@"Levels/Level1"];
    [_levelNode addChild:level];
    _physicsNode.collisionDelegate = self;
    _life = 100;
//    [_bullet addObserver:self forKeyPath:@"score" options:0 context:NULL];
    
}

// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  [self launchbullet];
}

- (void)launchbullet {
   // loads the bullet.ccb we have set up in Spritebuilder
   Bullet* bullet = (Bullet*)[CCBReader load:@"bullet"];
    // position the bullets at the front of the gun of mecha
   bullet.position = ccpAdd(_mech1.position, ccp(16, 60));
// add the bullet to the physicsNode of this scene (because it has physics enabled)

     [_physicsNode addChild:bullet];
  
//manually create & apply a force to launch the bullet
 CGPoint launchDirection = ccp(1, 0);
  CGPoint force = ccpMult(launchDirection, 8000);
  [bullet.physicsBody applyForce:force];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    // collision handling
    [self hit:wall];
    [GameDataCoin sharedData].coins += ((Bullet*)bullet).myCustomIsaac; //(i want to pull the value from the custom property set in bullet)+ armyunit.value;
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
