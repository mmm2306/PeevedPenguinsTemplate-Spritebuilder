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
    CCNode *_levelNode;
    CCNode *_contentNode;
    CCNode *_pullbackNode;
    CCNode *_mouseJointNode;
    CCPhysicsJoint *_mouseJoint;
}

-(void)didLoadFromCCB
{
    self.userInteractionEnabled = YES;
    CCScene *level = [CCBReader loadAsScene:@"Levels/Level1"];
    [_levelNode addChild:level];
    _physicsNode.debugDraw = YES;
    _pullbackNode.physicsBody.collisionMask = @[];
    _mouseJointNode.physicsBody.collisionMask = @[];
    
    
}

-(void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
//    [self launchPenguin];
    
    CGPoint touchlocation = [touch locationInNode:_contentNode];
    
    if (CGRectContainsPoint([_catapultArm boundingBox], touchlocation)) {
        _mouseJointNode.position = touchlocation;
        _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.f damping:150.f];
    }
}

-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    _mouseJointNode.position = [touch locationInNode:_contentNode];
}

-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self releaseCatapult];
}

-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    [self releaseCatapult];
}

-(void)releaseCatapult
{
    if (_mouseJoint != nil) {
        [_mouseJoint invalidate];
        _mouseJoint = nil;
    }
}

-(void)launchPenguin
{
    CCNode *penguin = [CCBReader load:@"Penguin"];
    penguin.position = ccpAdd(_catapultArm.position, ccp(16, 50));
    
    [_physicsNode addChild:penguin];
    
    CGPoint launchDirection = ccp(1, 0);
    CGPoint force = ccpMult(launchDirection, 8000);
    [penguin.physicsBody applyForce:force];
    
    self.position = ccp(0,0);
    CCActionFollow *follow = [CCActionFollow actionWithTarget:penguin worldBoundary:self.boundingBox];
    [_contentNode runAction:follow];
}

-(void)retry
{
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"Gameplay"]];
}

@end
