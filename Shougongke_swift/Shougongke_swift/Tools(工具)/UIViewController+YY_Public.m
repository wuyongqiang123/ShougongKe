//
//  UIViewController+ML_Public.m
//  哈哈
//
//  Created by 永强 on 15/12/14.
//  Copyright © 2015年 wyq. All rights reserved.
//

#import "UIViewController+YY_Public.h"
#import <objc/runtime.h>
#import "RDVTabBarController.h"

@implementation UIViewController (YY_Public)
- (UINavigationController*)YY_navigationController
{
    UINavigationController* nav = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        nav = (id)self;
    }
    else {
//        if ([self isKindOfClass:[UITabBarController class]]) {
//            nav = [((UITabBarController*)self).selectedViewController ml_navigationController];
//        }
        //这边不是用UITabBar
        if ([self isKindOfClass:[RDVTabBarController class]]) {
            nav = [((RDVTabBarController*)self).selectedViewController YY_navigationController];
        }
        else {
            nav = self.navigationController;
        }
    }
    return nav;
}
- (void)YY_push:(UIViewController*)viewController
{
    [self YY_push:viewController animated:YES];
}

- (void)YY_push:(UIViewController*)viewController animated:(BOOL)animated
{
    if(!self.rdv_tabBarController.isTabBarHidden){
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    }
    [self.YY_navigationController pushViewController:viewController animated:animated];
}

- (void)YY_present:(UIViewController*)viewController
{
    [self YY_present:viewController animated:YES];
}

- (void)YY_present:(UIViewController*)viewController animated:(BOOL)animated
{
    if (![viewController isKindOfClass:[UINavigationController class]]) {
        Class navigationControllerClass = [UINavigationController class];
        UINavigationController* nav = [[navigationControllerClass alloc] initWithRootViewController:viewController];
        [self YY_present:nav animated:animated];
    }
    else {
        [self presentViewController:viewController animated:animated completion:nil];
    }
}

- (UIViewController*)YY_pop:(BOOL)animated
{
    UINavigationController* nav = [self YY_navigationController];
    if (nav && nav.viewControllers.count > 1) {
        return [nav popViewControllerAnimated:animated];
    }
    else {
        [self dismissViewControllerAnimated:animated completion:nil];
        return nil;
    }
}

- (void)YY_removeSelfInNavigationController
{
    UIViewController* vc = self;
    if (vc.parentViewController && [vc.parentViewController isKindOfClass:[UINavigationController class]] == NO) {
        vc = vc.parentViewController;
    }

    UINavigationController* nav = vc.navigationController;
    if (nav && vc) {
        NSMutableArray* newStack = [NSMutableArray arrayWithArray:nav.viewControllers];
        NSInteger originalCount = newStack.count;
        [newStack removeObject:vc];
        NSInteger newCount = newStack.count;
        if (originalCount != newCount) {
            [nav setViewControllers:newStack animated:YES];
        }
    }
}

+ (UIViewController*)YY_deepestPresentedViewControllerOf:(UIViewController*)viewController
{
    UIViewController* deepestViewController = viewController;

    Class alertVC0 = [UIAlertController class];
    Class alertVC1 = NSClassFromString(@"_UIAlertShimPresentingViewController");
    while (YES) {
        UIViewController* presentedVC = deepestViewController.presentedViewController;
        if (presentedVC && [presentedVC isKindOfClass:alertVC0] == NO && [presentedVC isKindOfClass:alertVC1] == NO) {
            deepestViewController = deepestViewController.presentedViewController;
        }
        else {
            break;
        }
    }
    return deepestViewController;
}

+ (UIViewController*)YY_currentTopViewController
{
    UIViewController* rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    ;
    UIViewController* topVC = [self YY_deepestPresentedViewControllerOf:rootVC];

//    if ([topVC isKindOfClass:[UITabBarController class]]) {
//        UIViewController* tabSelectedVC = ((UITabBarController*)topVC).selectedViewController;
//        if (tabSelectedVC) {
//            topVC = [self YY_deepestPresentedViewControllerOf:tabSelectedVC];
//        }
//    }
    //这边不是用UITabBar
    if ([topVC isKindOfClass:[RDVTabBarController class]]) {
        UIViewController* tabSelectedVC = [((RDVTabBarController*)topVC).selectedViewController YY_navigationController];
        if (tabSelectedVC) {
            topVC = [self YY_deepestPresentedViewControllerOf:tabSelectedVC];
        }
    }

    if ([topVC isKindOfClass:[UINavigationController class]]) {
        UIViewController* navTopVC = ((UINavigationController*)topVC).topViewController;
        if (navTopVC) {
            topVC = [self YY_deepestPresentedViewControllerOf:navTopVC];
        }
    }

    return topVC;
}

@end
