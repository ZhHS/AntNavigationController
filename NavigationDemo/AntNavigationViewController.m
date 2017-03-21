//
//  AntNavigationViewController.m
//  NavigationDemo
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AntNavigationViewController.h"

@interface AntNavigationViewController ()<UINavigationControllerDelegate, UINavigationBarDelegate>

@end

@implementation AntNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        self.delegate = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}


//xib创建UINavigationController
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        if ([self isKindOfClass:[UINavigationController class]]) {
            NSArray *originalSelectorArr = @[@"_updateInteractiveTransition:"];
            for (NSString *selector in originalSelectorArr) {
                SEL originalSelector = NSSelectorFromString(selector);
                SEL swizzledSelector = NSSelectorFromString([NSString stringWithFormat:@"ant_%@",selector]);
                method_exchangeImplementations(class_getInstanceMethod([self classForCoder], originalSelector), class_getInstanceMethod([self classForCoder], swizzledSelector));
            }
        }
    }
    return self;
}

//代码创建UINavigationController
- (instancetype)init {
    
    if (self = [super init]) {
        if ([self isKindOfClass:[UINavigationController class]]) {
            NSArray *originalSelectorArr = @[@"_updateInteractiveTransition:"];
            for (NSString *selector in originalSelectorArr) {
                SEL originalSelector = NSSelectorFromString(selector);
                SEL swizzledSelector = NSSelectorFromString([NSString stringWithFormat:@"ant_%@",selector]);
                method_exchangeImplementations(class_getInstanceMethod([self classForCoder], originalSelector), class_getInstanceMethod([self classForCoder], swizzledSelector));
            }
        }
    }
    return self;
}

- (void)ant__updateInteractiveTransition:(CGFloat) percentComplete {
    [self ant__updateInteractiveTransition:percentComplete];
    AntViewController *topVC = (AntViewController *)self.topViewController;
    if (topVC) {
        if (topVC.transitionCoordinator) {
            AntViewController *fromController = [topVC.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
            AntViewController *toController = [topVC.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
            
            //透明度
            CGFloat fromAlpha = fromController.navigationBarAlpha;
            CGFloat toAlpha = toController.navigationBarAlpha;
            CGFloat nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete;
            [self setNeedsNavigationBackground:nowAlpha];
            
            //背景色
            UIColor *fromBarColor = fromController.navigationBarColor;
            UIColor *toBarColor = toController.navigationBarColor;
            UIColor *nowBarColor = [self averageColorFromeColor:fromBarColor toColor:toBarColor percent:percentComplete];
            self.navigationBar.barTintColor = nowBarColor;
            
            //背景图
//            UIImage *fromBarImage = fromController.navigationBarImage;
            UIImage *toBarImage = toController.navigationBarImage;
            [self.navigationBar setBackgroundImage:toBarImage forBarMetrics:UIBarMetricsDefault];
            
            //填充色
            UIColor *fromTintColor = fromController.navigationBarTintColor;
            UIColor *toTintColor = toController.navigationBarTintColor;
            UIColor *nowTintColor = [self averageColorFromeColor:fromTintColor toColor:toTintColor percent:percentComplete];
            self.navigationBar.tintColor = nowTintColor;
            
            //标题色
            UIColor *fromTitleColor = fromController.navigationBarTintColor;
            UIColor *toTitleColor = toController.navigationBarTintColor;
            UIColor *nowTitleColor = [self averageColorFromeColor:fromTitleColor toColor:toTitleColor percent:percentComplete];
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:nowTitleColor};
            
        }
    }
}

- (UIColor *)averageColorFromeColor: (UIColor *)fromColor toColor: (UIColor *)toColor percent: (CGFloat)percent {
    CGFloat fromRed = 0.0;
    CGFloat fromGreen = 0.0;
    CGFloat fromBlue = 0.0;
    CGFloat fromAlpha = 0.0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0.0;
    CGFloat toGreen = 0.0;
    CGFloat toBlue = 0.0;
    CGFloat toAlpha = 0.0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat nowRed = fromRed + (toRed-fromRed) * percent;
    CGFloat nowGreen = fromGreen + (toGreen-fromGreen) * percent;
    CGFloat nowBlue = fromBlue + (toBlue-fromBlue) * percent;
    CGFloat nowAlpha = fromAlpha + (toAlpha-fromAlpha) * percent;
    
    return [UIColor colorWithRed:nowRed green:nowGreen blue:nowBlue alpha:nowAlpha];
}

//设置导航栏透明度
- (void)setNeedsNavigationBackground: (CGFloat)alpha {
    
    id barBackgroundView = [self.navigationBar valueForKey:@"_barBackgroundView"];
    UIVisualEffectView *backgroundEffectView = [barBackgroundView valueForKey:@"_backgroundEffectView"];
    UIView *shadowView = [barBackgroundView valueForKey:@"_shadowView"];
    backgroundEffectView.alpha = alpha;
    shadowView.alpha = alpha;
}

#pragma mark -navigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    AntViewController *topVC = (AntViewController *)navigationController.topViewController;
    if (topVC) {
        id coor = topVC.transitionCoordinator;
        
        [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
            if ([context isCancelled]) {
                
                NSTimeInterval cancellDuration = [context transitionDuration] * [context percentComplete];
                [UIView animateWithDuration:cancellDuration animations:^{
                    AntViewController *fromVC = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
                    CGFloat nowAlpha = fromVC.navigationBarAlpha;
                    [self setNeedsNavigationBackground:nowAlpha];
                    [self.navigationBar setBackgroundImage:fromVC.navigationBarImage forBarMetrics:UIBarMetricsDefault];
                    self.navigationBar.tintColor = fromVC.navigationBarTintColor;
                    self.navigationBar.barTintColor = fromVC.navigationBarColor;
                    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:fromVC.navigationBarTitleColor};
                }];
            } else {
                
                NSTimeInterval finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
                [UIView animateWithDuration:finishDuration animations:^{
                    AntViewController *toVC = [context viewControllerForKey:UITransitionContextToViewControllerKey];
                    CGFloat nowAlpha = toVC.navigationBarAlpha;
                    [self setNeedsNavigationBackground:nowAlpha];
                    [self.navigationBar setBackgroundImage:toVC.navigationBarImage forBarMetrics:UIBarMetricsDefault];
                    self.navigationBar.tintColor = toVC.navigationBarTintColor;
                    self.navigationBar.barTintColor = toVC.navigationBarColor;
                    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:toVC.navigationBarTitleColor};
                }];
            }
        }];
    }
}

#pragma mark -navigationBar
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if (self.viewControllers.count >= navigationBar.items.count) {
        AntViewController *popToVC = self.viewControllers[self.viewControllers.count - 2];
        [self setNeedsNavigationBackground:popToVC.navigationBarAlpha];
        [self.navigationBar setBackgroundImage:popToVC.navigationBarImage forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.tintColor = popToVC.navigationBarTintColor;
        self.navigationBar.barTintColor = popToVC.navigationBarColor;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:popToVC.navigationBarTitleColor};
        [self popViewControllerAnimated:YES];
    }
    return YES;
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPushItem:(UINavigationItem *)item {
    AntViewController *topVC = (AntViewController *)self.topViewController;
    [self setNeedsNavigationBackground: topVC.navigationBarAlpha];
    [self.navigationBar setBackgroundImage:topVC.navigationBarImage forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = topVC.navigationBarTintColor;
    self.navigationBar.barTintColor = topVC.navigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:topVC.navigationBarTitleColor};
    return YES;
}

@end
