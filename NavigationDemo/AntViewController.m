//
//  AntViewController.m
//  NavigationDemo
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AntViewController.h"
#import "AntNavigationViewController.h"


@interface AntViewController ()

@property (nonatomic, assign) CGFloat objc_navigationBarAlpha;
@property (nonatomic, strong) UIColor *objc_navigationBarColor;
@property (nonatomic, strong) UIImage *objc_navigationBarImage;
@property (nonatomic, strong) UIColor *objc_navigationBarTintColor;
@property (nonatomic, strong) UIColor *objc_navigationBarTitleColor;

@end

@implementation AntViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - 
#pragma mark - 透明度
- (CGFloat)navigationBarAlpha {
    CGFloat alpha = [objc_getAssociatedObject(self, &_objc_navigationBarAlpha) floatValue];
    return alpha;
}

- (void)setNavigationBarAlpha:(CGFloat)navigationBarAlpha {
    CGFloat alpha = navigationBarAlpha;
    if (alpha > 1) {
        alpha = 1;
    }
    if (alpha < 0) {
        alpha = 0;
    }
    objc_setAssociatedObject(self, &_objc_navigationBarAlpha, [NSNumber numberWithDouble:alpha], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    AntNavigationViewController *antNavigationVC = (AntNavigationViewController *)self.navigationController;
    [antNavigationVC setNeedsNavigationBackground:alpha];
}

#pragma mark - 
#pragma mark - 背景色
- (UIColor *)navigationBarColor {
    UIColor *barColor = objc_getAssociatedObject(self, &_objc_navigationBarColor);
    if (!barColor) {
        return DefaultNavigationBarColor;
    }
    return barColor;
}

- (void)setNavigationBarColor:(UIColor *)navigationBarColor {
    self.navigationController.navigationBar.barTintColor = navigationBarColor;
    objc_setAssociatedObject(self, &_objc_navigationBarColor, navigationBarColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark -
#pragma mark - 背景图
- (UIImage *)navigationBarImage {
    UIImage *bgImage = objc_getAssociatedObject(self, &_objc_navigationBarImage);
    if (!bgImage) {
        return [UIImage imageNamed:@""];
    }
    return bgImage;
}

- (void)setNavigationBarImage:(UIImage *)navigationBarImage {
    [self.navigationController.navigationBar setBackgroundImage:navigationBarImage forBarMetrics:UIBarMetricsDefault];
    objc_setAssociatedObject(self, &_objc_navigationBarImage, navigationBarImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 
#pragma mark - 填充色
- (UIColor *)navigationBarTintColor {
    UIColor *tintColor = objc_getAssociatedObject(self, &_objc_navigationBarTintColor);
    if (!tintColor) {
        return DefaultNavigationBarTintColor;
    }
    return tintColor;
}

- (void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor {
    self.navigationController.navigationBar.tintColor = navigationBarTintColor;
    objc_setAssociatedObject(self, &_objc_navigationBarTintColor, navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark - 标题颜色
- (UIColor *)navigationBarTitleColor {
    UIColor *titleColor = objc_getAssociatedObject(self, &_objc_navigationBarTintColor);
    if (!titleColor) {
        return DefaultNavigationBarTintColor;
    }
    return titleColor;
}

- (void)setNavigationBarTitleColor:(UIColor *)navigationBarTitleColor {
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:navigationBarTitleColor};
    objc_setAssociatedObject(self, &_objc_navigationBarTintColor, navigationBarTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
