//
//  PlayingCard.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; //提供了getter AND setter就得自己创建实例变量

- (NSString *)contents
{
    return [NSString stringWithFormat:@"%@%@",[PlayingCard rankStrings][self.rank],self.suit];
}

-(int)match:(NSArray *)cards
{
    int score = 0;
    
    for (PlayingCard *otherCard in cards) {
        if ([self.contents isEqualToString:otherCard.contents]) {
            continue;
        }
        if ([otherCard.suit isEqualToString:self.suit]) {
            score += 2;
        }
        if (self.rank == otherCard.rank) {
            score += 4;
        }
    }
    return score;
}


+ (NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSUInteger)rank
{
    if (rank < [[PlayingCard rankStrings] count]) {
        _rank = rank;
    }
}


@end
