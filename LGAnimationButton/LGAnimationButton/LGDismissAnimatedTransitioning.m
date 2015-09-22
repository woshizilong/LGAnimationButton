//
//  LGDismissAnimatedTransitioning.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/22.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGDismissAnimatedTransitioning.h"

@implementation LGDismissAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *contextView = [transitionContext containerView];
    UIViewController *fromViewCtrl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewCtrl];
    toViewCtrl.view.frame = finalFrame;
    [contextView addSubview:toViewCtrl.view];
    [contextView sendSubviewToBack:toViewCtrl.view];
    toViewCtrl.view.alpha = 0.5;
    
    UIView *snapeView = [fromViewCtrl.view snapshotViewAfterScreenUpdates:NO];
    snapeView.frame = fromViewCtrl.view.frame;
    [contextView addSubview:snapeView];
    
    [fromViewCtrl.view removeFromSuperview];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewCtrl.view.alpha = 1.0;
        snapeView.frame = CGRectInset(fromViewCtrl.view.frame, fromViewCtrl.view.frame.size.width / 2, fromViewCtrl.view.frame.size.height / 2);
        snapeView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        snapeView.transform = CGAffineTransformIdentity;
        [snapeView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
