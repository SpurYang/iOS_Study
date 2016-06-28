//
//  CounterView.m
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/16.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "CounterView.h"

const int numOfGlasses = 8;

@implementation CounterView

- (void)drawRect:(CGRect)rect
{
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MAX(rect.size.width, rect.size.height) / 2;
    CGFloat startAngle = 3 * M_PI / 4;
    CGFloat endAngle = M_PI / 4;
    //counter
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius - _lineWidth/2
                                                       startAngle:startAngle
                                                         endAngle:endAngle
                                                        clockwise:YES];
    arcPath.lineWidth = _lineWidth;
    [_counterColor setStroke];
    [arcPath stroke];
    //outline
    CGFloat angleDifference = 2 * M_PI - startAngle + endAngle;
    
    CGFloat arcAngleOfPerGlass = angleDifference / numOfGlasses;
    
    CGFloat outlineEndAngel = startAngle + arcAngleOfPerGlass * (_count % (numOfGlasses + 1));
    
    //outline outer
    UIBezierPath *outlinePath = [UIBezierPath bezierPathWithArcCenter:center
                                                           radius:radius - 2.5
                                                       startAngle:startAngle
                                                         endAngle:outlineEndAngel
                                                        clockwise:YES];
    
    //outline inner
    [outlinePath addArcWithCenter:center
                           radius:radius - _lineWidth + 2.5
                       startAngle:outlineEndAngel
                         endAngle:startAngle
                        clockwise:NO];
    [outlinePath closePath];
    [_outlineColor setStroke];
    outlinePath.lineWidth = 5.0;
    if (_count != 0) {
        [outlinePath stroke];
    }

}

@end
