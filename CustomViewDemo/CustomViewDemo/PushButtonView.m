//
//  PushButtonView.m
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/15.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "PushButtonView.h"

@implementation PushButtonView


//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _isAddButton = YES;
//        _bgColor = [UIColor greenColor];
//        _symbolColor = [UIColor whiteColor];
//    }else{
//        self = nil;
//    }
//    return self;
//}




- (void)drawRect:(CGRect)rect
{
    UIBezierPath* bezierpath = [UIBezierPath bezierPathWithOvalInRect:rect];
    [_bgColor setFill];
    [bezierpath fill];
    
    
    CGFloat plusLineWidth = 3.0;
    CGFloat plusWidth = MIN(rect.size.width, rect.size.height) * 0.6;
    UIBezierPath* plusPath = [[UIBezierPath alloc] init];
    plusPath.lineWidth = plusLineWidth;
    
    //draw symbol
    [plusPath moveToPoint:CGPointMake(rect.size.width/2 - plusWidth/2 + 0.5,
                                      rect.size.height/2 + 0.5)];
    [plusPath addLineToPoint:CGPointMake(rect.size.width/2 + plusWidth/2 + 0.5,
                                         rect.size.height/2 + 0.5)];
    
    //_isAddButton = YES;
    if (_isAddButton) {
        [plusPath moveToPoint:CGPointMake(rect.size.width/2 + 0.5,
                                          rect.size.height/2 - plusWidth/2 + 0.5)];
        [plusPath addLineToPoint:CGPointMake(rect.size.width/2 + 0.5,
                                             rect.size.height/2 + plusWidth/2 + 0.5)];
    }
    
    
    [_symbolColor setStroke];
    [plusPath stroke];
    
    
    
    
}

@end
