//
//  LGInteractiveTransition.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/22.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGInteractiveTransition.h"

@implementation LGInteractiveTransition

-(void)attachToViewController:(UIViewController *)viewController
{
    self.navigationController = viewController.navigationController;
    [self setUpGestureRecognizer:viewController.view];
}

- (void)setUpGestureRecognizer:(UIView *)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    CGPoint viewTranslation = [gesture translationInView:gesture.view.superview];
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.transitionInProgress = YES;
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat constValue = fminf(fmaxf((float)(viewTranslation.x / 200.0), 0.0), 1.0);
            self.shouldCompleteTransition = constValue > 0.5;
            [self updateInteractiveTransition:constValue];
        }
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            self.transitionInProgress = NO;
            if (!self.shouldCompleteTransition || gesture.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            }
            else
            {
                [self finishInteractiveTransition];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
