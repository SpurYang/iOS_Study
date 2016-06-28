//
//  PlayingCard.h
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong,nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
@end
