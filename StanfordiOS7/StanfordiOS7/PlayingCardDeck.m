//
//  PlayingCardDeck.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayingCard validSuits])
            for (NSUInteger rank = 1; rank < [[PlayingCard rankStrings] count]; rank++) {
                PlayingCard* card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
    }
    
    return self;
}



@end
