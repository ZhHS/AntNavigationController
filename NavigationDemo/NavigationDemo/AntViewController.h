//
//  AntViewController.h
//  NavigationDemo
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define DefaultNavigationBarColor [UIColor whiteColor]
#define DefaultNavigationBarTintColor [UIColor colorWithRed:0.0 green:0.478431 blue:1.0 alpha:1.0]

@interface AntViewController : UIViewController

///导航栏透明度
@property (nonatomic, assign) CGFloat navigationBarAlpha;

///导航栏背景颜色
@property (nonatomic, strong) UIColor *navigationBarColor;

///导航栏填充色
@property (nonatomic, strong) UIColor *navigationBarTintColor;

///导航栏标题颜色
@property (nonatomic, strong) UIColor *navigationBarTitleColor;


@end
