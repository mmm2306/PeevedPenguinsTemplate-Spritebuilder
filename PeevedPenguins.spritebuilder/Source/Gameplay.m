//
//  Gameplay.m
//  PeevedPenguins
//
//  Created by Mihai on 3/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "Gameplay.h"

@implementation Gameplay
{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
}

-(void)didLoadFromCCB
{
    self.userInteractionEnabled = YES;
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self launchPenguin];
}

-(void)launchPenguin
{
    CCNode *penguin = [CCBReader load:@"Penguin"];
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(3, 1);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
}

@end
