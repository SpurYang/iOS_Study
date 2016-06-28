//
//  ViewController.m
//  CustomViewDemo
//
//  Created by SpurYang on 15/12/15.
//  Copyright © 2015年 SpurYang. All rights reserved.
//

#import "ViewController.h"

#import "CounterView.h"
#import "PushButtonView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet CounterView *couterView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (weak, nonatomic) IBOutlet UIView *outerView;
@property (nonatomic) BOOL isGraphViewShowing;
@property (strong,nonatomic) NSMutableArray *valueArray;
@end


@implementation ViewController



- (IBAction)counterViewTap:(UITapGestureRecognizer *)sender {
    if (_isGraphViewShowing) {
        [UIView transitionFromView:_graphView
                            toView:_couterView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];

    }else{
        [UIView transitionFromView:_couterView
                            toView:_graphView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft| UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
    }
    _isGraphViewShowing = !_isGraphViewShowing;
}


- (IBAction)changeCount:(PushButtonView *)sender {
    if (sender.isAddButton) {
        if (_couterView.count < 8)
                _couterView.count++;
    }else{
        if (_couterView.count > 0)
                _couterView.count--;
    }
    [_couterView setNeedsDisplay];
    _countLabel.text = [NSString stringWithFormat:@"%d",_couterView.count];
    if (_isGraphViewShowing) {
        [self counterViewTap:nil];
    }
}

- (NSMutableArray *)valueArray
{
    if (_valueArray == nil) {
        _valueArray = [NSMutableArray arrayWithObjects:@4,@2,@6,@4,@5,@8,@3,nil];
    }
    return _valueArray;
}


//---------------GraphView DataSource---------------
- (int)numberOfPointInGraphView
{
    return (int)[self.valueArray count];
}

- (CGFloat)pointValueAtIndex:(int)index
{
    CGFloat value;
    int intValue = (int)[self.valueArray objectAtIndex:index];
    value = intValue;
    return value;
}

- (CGFloat)maxVuleInGraphView
{
    CGFloat maxValue;
    int max = (int)[self.valueArray objectAtIndex:0];
    for (id value in self.valueArray) {
        int pointValue = (int)value;
        if (max < pointValue) {
            max = pointValue;
        }
    }
    maxValue = max;
    return maxValue;
}

- (CGFloat)minValueInGraphView
{
    CGFloat minValue;
    int min = (int)[self.valueArray objectAtIndex:0];
    for (id value in self.valueArray) {
        int pointValue = (int)value;
        if (min > pointValue) {
            min = pointValue;
        }
    }
    minValue = min;
    return minValue;
}










- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _graphView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
