//
//  CardMatchingGame.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "CardMatchingGame.h"

const static int MATCHED_CX = 4;
const static int UNMATCHED_CX = 10;

@interface CardMatchingGame()
@property (nonatomic,strong) NSMutableArray *cards;
@property (nonatomic,readwrite) int score;
@property (nonatomic,strong) Deck *deck;
@end

@implementation CardMatchingGame

//designated initializer
- (instancetype)initWithCount:(NSInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (NSInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            }
            [self.cards addObject:card];
        }
        _deck = deck;
    }
    _matchingCount = 2;
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    static int chosenCount;
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            chosenCount--;
        }else{
            card.chosen = YES;
            if (++chosenCount == _matchingCount ) {
                
                NSMutableArray *matcheCards = [NSMutableArray new];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [matcheCards addObject:otherCard];
                    }
                }
                int matchScore = [card match:matcheCards];
                if (matchScore) {
                    self.score += matchScore * MATCHED_CX;
                    for (Card *card in  matcheCards) {
                        card.matched = YES;
                    }
                }else{
                    self.score -= UNMATCHED_CX;
                    for (Card * card in matcheCards) {
                        card.chosen = NO;
                    }
                }
                chosenCount = 0;
            }
            
        }
        self.score--;
    }
}

- (void)rePlay
{
    //分数归零
    _score = 0;
    NSInteger count = [self.cards count];
    [self.cards removeAllObjects];
    for (NSInteger i = 0; i < count; i++) {
        Card *card = [_deck drawRandomCard];
        if (!card) {
            break;
        }
        [self.cards addObject:card];
    }

}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}



@end
