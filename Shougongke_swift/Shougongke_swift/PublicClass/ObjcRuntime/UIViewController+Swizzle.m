//
//  UIViewController+Swizzle.m
//  Zhuangpin
//
//  Created by PBA on 15/12/16.
//  Copyright © 2015年 ZhuangPin. All rights reserved.
//

#import "UIViewController+Swizzle.h"
#import "ObjcRuntime.h"
#import "RDVTabBarController.h"
@implementation UIViewController (Swizzle)

- (void)customViewDidAppear:(BOOL)animated{
    NSLog(@"class = %@",NSStringFromClass([self class]));
    if ([NSStringFromClass([self class]) rangeOfString:@"_RootViewController"].location != NSNotFound) {
        [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
        NSLog(@"setTabBarHidden:NO --- customViewDidAppear : %@", NSStringFromClass([self class]));
    }
    [self customViewDidAppear:animated];
}

- (void)customviewWillAppear:(BOOL)animated{
    NSLog(@"class-count = %lu",[self.navigationController childViewControllers].count);
    if ([[self.navigationController childViewControllers] count] > 1) {
        [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
        NSLog(@"setTabBarHidden:YES --- customviewWillAppear : %@", NSStringFromClass([self class]));
    }
    [self customviewWillAppear:animated];
}

+ (void)load{
    swizzleAllViewController();
}

@end

void swizzleAllViewController()
{
    Swizzle([UIViewController class], @selector(viewDidAppear:), @selector(customViewDidAppear:));
    Swizzle([UIViewController class], @selector(viewWillAppear:), @selector(customviewWillAppear:));
}
