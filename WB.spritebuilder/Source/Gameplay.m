//
//  Gameplay.m
//  WB
//
//  Created by Jonathan Alcontin on 7/10/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Gameplay.h"
#import "Bullet.h"
@implementation Gameplay {
    CCPhysicsNode *_physicsNode;
    CCNode *_mech1;
    CCNode *_levelNode;
    CCNode *_bullet;
}
// is called when CCB file has completed loading
- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    CCNode *level = [CCBReader load:@"Levels/Level1"];
    [_levelNode addChild:level];
    _physicsNode.collisionDelegate = self;
    
}

// called on every touch in this scene
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  [self launchbullet];
}

- (void)launchbullet {
   // loads the bullet.ccb we have set up in Spritebuilder
   CCNode* bullet = [CCBReader load:@"bullet"];
    // position the bullets at the front of the gun of mecha
   bullet.position = ccpAdd(_mech1.position, ccp(80, 10));
// add the bullet to the physicsNode of this scene (because it has physics enabled)

     [_physicsNode addChild:bullet];
  
//manually create & apply a force to launch the bullet
 CGPoint launchDirection = ccp(5, 0);
  CGPoint force = ccpMult(launchDirection, 8000);
  [bullet.physicsBody applyForce:force];
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair bullet:(CCNode *)bullet wall:(CCNode *)wall {
    // collision handling
    [self hit];
    [bullet removeFromParent];
    CCLOG(@"Bullet hit the wall finnally!");
    
}


@end
