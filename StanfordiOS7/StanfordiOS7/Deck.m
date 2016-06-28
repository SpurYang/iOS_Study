//
//  Deck.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "Deck.h"

@interface Deck()  //Private
@property(strong,nonatomic)NSMutableArray *cards;
@end

@implementation Deck


- (NSMutableArray *)cards
{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}


- (Card *)drawRandomCard
{
    Card *randomCard;
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}
@end
