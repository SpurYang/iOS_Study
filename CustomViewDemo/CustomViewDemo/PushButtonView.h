//
//  PushButtonView.h
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/15.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface PushButtonView : UIButton

@property(nonatomic) IBInspectable BOOL isAddButton;
@property(nonatomic,strong) IBInspectable UIColor *symbolColor;
@property(nonatomic,strong) IBInspectable UIColor *bgColor;

@end
