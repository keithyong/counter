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

#define incrButtonWidth     396
#define incrButtonHeight    182

@implementation GameScene

/* The increment button textures and sizes */
SKSpriteNode *incrButton;
CGPoint incrButtonDefaultPosition;
CGSize incrButtonSize;

/* Since the drop shadow adds a small bit of Y volume 
 * to the button texture, we need to offset the Y position
 * by a bit so it doesn't look like shit when pressed. */
int incrButtonPressedYOffset = 2;

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

-(void)initButtons:(CGPoint) buttonPosition {
    /* Initialize the increment button sets */
    incrButtonSize = CGSizeMake(incrButtonWidth, incrButtonHeight);
    incrButtonDefaultPosition = buttonPosition;

    /* Initialize unpressed and press button sizes and textures */
    incrButtonUpSize = incrButtonSize;
    incrButtonDownSize = CGSizeMake(incrButtonSize.width, incrButtonSize.height - 8);
    
    incrButtonUpTexture = [SKTexture textureWithImageNamed:@"buttonUp"];
    incrButtonDownTexture = [SKTexture textureWithImageNamed:@"buttonDown"];
    
    /* Set initial texture to be unpressed button */
    incrButton = [SKSpriteNode spriteNodeWithTexture:incrButtonUpTexture];
    [incrButton setSize:incrButtonSize];
    [incrButton setPosition:buttonPosition];
}

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
    
    [self initButtons:mid];

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
    /* TODO: It feels hacky making a 2x2 rect of touch location. Change to a better more elegant method. */
    CGRect touchLocation = CGRectMake(location.x, location.y, 1, 1);
    
    if (CGRectIntersectsRect(touchLocation, incrButton.calculateAccumulatedFrame)) {
        [incrButton setTexture:incrButtonDownTexture];
        [incrButton setSize:incrButtonDownSize];
        [incrButton setPosition:CGPointMake(incrButtonDefaultPosition.x,
                                            incrButtonDefaultPosition.y - incrButtonPressedYOffset)];
        [self updateCounter];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    [incrButton setTexture:incrButtonUpTexture];
    [incrButton setSize:incrButtonUpSize];
    [incrButton setPosition:incrButtonDefaultPosition];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
