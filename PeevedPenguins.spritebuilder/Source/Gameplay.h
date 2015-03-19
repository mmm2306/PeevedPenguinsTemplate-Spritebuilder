//
//  Gameplay.h
//  PeevedPenguins
//
//  Created by Mihai on 3/18/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate>

-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair seal:(CCNode *)nodeA wildcard:(CCNode *)nodeB;

@end
