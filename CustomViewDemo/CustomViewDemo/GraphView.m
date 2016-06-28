//
//  GraphView.m
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/16.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView





// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //add background clipping area
    CGSize raduis = {8.0,8.0};
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:raduis];
    
    [clipPath addClip];
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = [NSArray arrayWithObjects:(id)_startColor.CGColor,(id)_endColor.CGColor, nil];
    CGFloat locations[] = {0.0,1.0};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                         (CFArrayRef)colors,
                                                         locations);
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0, rect.size.height);
    CGContextDrawLinearGradient(context,
                                gradient,
                                startPoint,
                                endPoint,
                                0);
    
    [self drawLines:rect :gradient];
    
    
}


- (void)drawLines:(CGRect)rect :(CGGradientRef)gradient{
    //save context
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSaveGState()
    //margin
    CGFloat margin = 20.0;
    CGFloat topBorder = 60;
    CGFloat bottomBordre = 50;
    
    //caculator X-raw point
    CGFloat (^columnXPoint) (int);
    //caculator Y-raw point
    CGFloat (^columnYPoint)(int);
    
    if (_dataSource != nil) {
        int points = [_dataSource numberOfPointInGraphView];
        //assign to X block
        columnXPoint = ^CGFloat (int column){
            CGFloat spacer = (rect.size.width - margin * 2 - 4) / (points - 1);
            CGFloat x = spacer * column + margin + 2;
            return x;
        };
        //assign to Y block
        columnYPoint = ^CGFloat (int column){
            CGFloat y;
            CGFloat maxValue = [_dataSource maxVuleInGraphView];
            //CGFloat minValue = [_dataSource minValueInGraphView];
            
            CGFloat graphHeight = rect.size.height - topBorder - bottomBordre;
            y = graphHeight / maxValue * [_dataSource pointValueAtIndex:column];
            y = graphHeight + topBorder - y;
            return y;
        };
        /*
         * Darw
         */
        
        //draw lines
        UIBezierPath *linePath = [[UIBezierPath alloc] init];
        [linePath moveToPoint:CGPointMake(columnXPoint(0), columnYPoint(0))];
        
        for (int i = 1; i < points; i++) {
            [linePath addLineToPoint:CGPointMake(columnXPoint(i), columnYPoint(i))];
        }
        [_lineColor setStroke];
        [linePath stroke];
        
        //draw gradient graph under the lines
        
        //2 - make a copy of the path
        UIBezierPath *clippingPath = [linePath copy];
        //3 - add lines to the copied path to complete the clip area
        [clippingPath addLineToPoint:CGPointMake(columnXPoint(points - 1), rect.size.height)];
        [clippingPath addLineToPoint:CGPointMake(columnXPoint(0), rect.size.height)];
        [clippingPath closePath];
        //4 - add the clipping path to the context
        [clippingPath addClip];
        //5 - add gradient
        
        CGPoint startPoint = CGPointMake(margin, topBorder);
        CGPoint endPonit = CGPointMake(margin, rect.size.height);
        CGContextDrawLinearGradient(context, gradient, startPoint, endPonit, 0);
        //6 - Restore Context
        //CGContextRestoreGState(context);
        
        
        
        
        
        
    }
}







@end
