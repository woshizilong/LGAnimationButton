//
//  LGAnimatedTransitioning.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/21.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGAnimatedTransitioning.h"

@implementation LGAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}


-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *contextView = [transitionContext containerView];
    UIViewController *fromViewCtrl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalRect = [transitionContext finalFrameForViewController:toViewCtrl];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    
    toViewCtrl.view.frame = CGRectOffset(finalRect, 0, -screenBounds.size.height);
    
    [contextView addSubview:toViewCtrl.view];
    
   [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       fromViewCtrl.view.alpha = 0.5;
       toViewCtrl.view.frame = finalRect;
   } completion:^(BOOL finished) {
       fromViewCtrl.view.alpha = 1;
       [transitionContext completeTransition:YES];
   }];
}

@end
