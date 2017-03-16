//
//  MainViewController.m
//  NavigationDemo
//
//  Created by ZhHS on 2017/3/13.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MainViewController.h"
#import "FirstViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationBarAlpha = 0.0;
}

- (IBAction)pushToOtherViewController {
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    firstVC.navigationItem.title = @"First ViewController";
    [self.navigationController pushViewController:firstVC animated:YES];
}

@end
