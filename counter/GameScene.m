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
SKSpriteNode *buttonUp;
CGSize buttonSize;

SKTexture *buttonUpTexture;
CGSize buttonUpSize;

SKTexture *buttonDownTexture;
CGSize buttonDownSize;

SKLabelNode *counter;
CGPoint counterLocation;
int count;
NSString *countStr;
            
-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    count = 0;
    countStr = [@(count) stringValue];
    
    /* Initialize counter */
    counter = [SKLabelNode labelNodeWithFontNamed:@"Menlo"];
    [counter setText:countStr];
    [counter setFontSize:70];
    [counter setPosition:CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame) + 120)];
    
    buttonUpSize = CGSizeMake(396, 182);
    buttonDownSize = CGSizeMake(396, 174);
    
    buttonUpTexture = [SKTexture textureWithImageNamed:@"buttonUp"];
    buttonDownTexture = [SKTexture textureWithImageNamed:@"buttonDown"];
    
    buttonUp = [SKSpriteNode spriteNodeWithTexture:buttonUpTexture];
    [buttonUp setSize:buttonUpSize];
    buttonUp.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:buttonUp];
    [self addChild:counter];
    
    [self setName:@"Counter"];
}

-(void)updateCounter {
    count++;
    countStr = [@(count) stringValue];
    [counter setText:countStr];
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
    
    CGPoint location = [theEvent locationInNode:self];
    CGRect touchLocation = CGRectMake(location.x, location.y, 2, 2);
    if (CGRectIntersectsRect(touchLocation, buttonUp.calculateAccumulatedFrame)) {
        [buttonUp setTexture:buttonDownTexture];
        [buttonUp setSize:buttonDownSize];
        [self updateCounter];
    }
}

-(void)mouseUp:(NSEvent *)theEvent {
    CGPoint location = [theEvent locationInNode:self];
    CGRect touchLocation = CGRectMake(location.x, location.y, 2, 2);
    if (CGRectIntersectsRect(touchLocation, buttonUp.calculateAccumulatedFrame)) {
        [buttonUp setTexture:buttonUpTexture];
        [buttonUp setSize:buttonUpSize];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
