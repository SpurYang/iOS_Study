//
//  ViewController.m
//  Runtime_MSG_DISPATCH
//
//  Created by SpurYang on 16/3/17.
//  Copyright © 2016年 SpurYang. All rights reserved.
//

#import "ViewController.h"
#import "DynamicProperty.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DynamicProperty *dp = [DynamicProperty new];
    
    dp.name = @"SpurYang_Dynamic_MSG_Dispatch";
    
    NSLog(@"%@",dp.name);
    
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
