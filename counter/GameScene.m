//
//  GameScene.m
//  KeithRPG
//
//  Created by Keith Yong on 1/3/15.
//  Copyright (c) 2015 keith. All rights reserved.
//

#import "GameScene.h"
#include <string.h>
#include <stdlib.h>

@implementation GameScene

/* The increment button textures and sizes */
SKSpriteNode *incrButton;
CGSize buttonSize;

SKTexture *incrButtonUpTexture;
CGSize incrButtonUpSize;

SKTexture *incrButtonDownTexture;
CGSize incrButtonDownSize;

/* Counter label node and variables */
SKLabelNode *counter;
CGPoint counterLocation;
int count;
NSString *countStr;

CGPoint mid;

-(void)didMoveToView:(SKView *)view {
    /* Middle of frame */
    mid = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    /* Initialize counter */
    count = 0;
    countStr = [@(count) stringValue];
    counter = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    [counter setText:countStr];
    [counter setFontSize:70];
    [counter setPosition:CGPointMake(mid.x, mid.y + 120)];
    
    /* Initialize the increment button sets */
    incrButtonUpSize = CGSizeMake(396, 182);
    incrButtonDownSize = CGSizeMake(396, 174);
    
    incrButtonUpTexture = [SKTexture textureWithImageNamed:@"incrButton"];
    incrButtonDownTexture = [SKTexture textureWithImageNamed:@"buttonDown"];
    
    incrButton = [SKSpriteNode spriteNodeWithTexture:incrButtonUpTexture];
    [incrButton setSize:incrButtonUpSize];
    [incrButton setPosition:mid];
    
    /* Add button and counter label to view */
    [self addChild:incrButton];
    [self addChild:counter];
}

-(void)updateCounter {
    count++;
    countStr = [@(count) stringValue];
    [counter setText:countStr];
}

-(void)mouseDown:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    CGRect touchLocation = CGRectMake(location.x, location.y, 2, 2);
    
    if (CGRectIntersectsRect(touchLocation, incrButton.calculateAccumulatedFrame)) {
        [incrButton setTexture:incrButtonDownTexture];
        [incrButton setSize:incrButtonDownSize];
        [self updateCounter];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    CGRect touchLocation = CGRectMake(location.x, location.y, 2, 2);
    
    if (CGRectIntersectsRect(touchLocation, incrButton.calculateAccumulatedFrame)) {
        [incrButton setTexture:incrButtonUpTexture];
        [incrButton setSize:incrButtonUpSize];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
