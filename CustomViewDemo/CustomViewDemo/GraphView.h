//
//  GraphView.h
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/16.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GraphViewDataSource <NSObject>

@required
- (int)numberOfPointInGraphView;
- (CGFloat)pointValueAtIndex:(int) index;
- (CGFloat)maxVuleInGraphView;
- (CGFloat)minValueInGraphView;

@end



IB_DESIGNABLE
@interface GraphView : UIView

@property(nonatomic,strong) IBInspectable UIColor * startColor;
@property(nonatomic,strong) IBInspectable UIColor * endColor;
@property(nonatomic,strong) IBInspectable UIColor * lineColor;

//protocol
@property(nonatomic,weak,nullable) id<GraphViewDataSource> dataSource;

@end
