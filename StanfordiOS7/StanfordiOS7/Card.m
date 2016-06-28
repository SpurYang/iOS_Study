//
//  Card.m
//  StanfordiOS7
//
//  Created by SpurYang on 15/12/7.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize contents = _contents;

- (int)match:(NSArray *)cards
{
    int score = 0;
    
    for (Card * card in cards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    
    return score;
}
@end
