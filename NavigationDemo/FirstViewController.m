//
//  FirstViewController.m
//  NavigationDemo
//
//  Created by ZhHS on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationBarAlpha = 1.0;
    self.navigationBarColor = [UIColor redColor];
    self.navigationBarTitleColor = [UIColor yellowColor];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏-再来"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏-再来"] forBarMetrics:UIBarMetricsDefault];
    
}

@end
