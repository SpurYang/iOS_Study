//
//  CardMatchingGame.h
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype)initWithCount:(NSInteger)count usingDeck:(Deck *)deck;

- (Card *)cardAtIndex:(NSUInteger)index;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (void)rePlay;

@property (nonatomic) int matchingCount;
@property (nonatomic,readonly) int score;
@end
