//
//  UIViewController+ML_Public.h
//  哈哈
//
//  Created by 永强 on 15/12/14.
//  Copyright © 2015年 wyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (YY_Public)

- (void)YY_push:(UIViewController *)viewController;

- (void)YY_push:(UIViewController *)viewController animated:(BOOL)animated;

- (void)YY_present:(UIViewController *)viewController;

- (void)YY_present:(UIViewController *)viewController animated:(BOOL)animated;

- (UIViewController*)YY_pop:(BOOL)animated;

///目前 rootViewController 里面最顶层的 vc
+ (UIViewController*)YY_currentTopViewController;

///找到最顶层的viewController
+ (UIViewController*)YY_deepestPresentedViewControllerOf:(UIViewController*)viewController;

///该vc的navigationController
- (UINavigationController*)YY_navigationController;


@end
