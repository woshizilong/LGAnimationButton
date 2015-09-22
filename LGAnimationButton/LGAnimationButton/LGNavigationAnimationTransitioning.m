//
//  LGNavigationAnimationTransitioning.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/22.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGNavigationAnimationTransitioning.h"

@implementation LGNavigationAnimationTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.5;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewCtrl = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewCtrl = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *contextView = [transitionContext containerView];
    UIView *fromView = fromViewCtrl.view;
    UIView *toView = toViewCtrl.view;
    
    CGFloat direction = self.reverse? -1 : 1;
    NSLog(@"%f", direction);
    CGFloat constVaule = -0.005;
    
    toView.layer.anchorPoint = CGPointMake(direction == 1? 0 : 1, 0.5);
    fromView.layer.anchorPoint = CGPointMake(direction == 1? 1 : 0, 0.5);
    
    CATransform3D fromTransfrom = CATransform3DMakeRotation(direction * (float)( M_PI_2), 0, 1, 0);
    CATransform3D toTransform = CATransform3DMakeRotation(-direction * (float)( M_PI_2), 0, 1, 0);
    fromTransfrom.m34 = constVaule;
    toTransform.m34 = constVaule;
    
    contextView.transform = CGAffineTransformMakeTranslation(direction * contextView.frame.size.width / 2, 0);
    
    toView.layer.transform = toTransform;
    [contextView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        contextView.transform = CGAffineTransformMakeTranslation(-direction * contextView.frame.size.width / 2, 0);
        fromView.layer.transform = fromTransfrom;
        toView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        contextView.transform = CGAffineTransformIdentity;
        fromView.layer.transform = CATransform3DIdentity;
        toView.layer.transform = CATransform3DIdentity;
        fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        if ([transitionContext transitionWasCancelled]) {
            [toView removeFromSuperview];
        }
        else
        {
            [fromView removeFromSuperview];
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

@end
