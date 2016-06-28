//
//  CounterView.h
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/16.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface CounterView : UIView

@property(nonatomic) IBInspectable int count;
@property(nonatomic) IBInspectable CGFloat lineWidth;
@property(nonatomic,strong) IBInspectable UIColor *counterColor;
@property(nonatomic,strong) IBInspectable UIColor *outlineColor;
@end
