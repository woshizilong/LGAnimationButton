//
//  LGInteractiveTransition.h
//  LGAnimationButton
//
//  Created by jamy on 15/9/22.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGInteractiveTransition : UIPercentDrivenInteractiveTransition
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, assign) BOOL shouldCompleteTransition;
@property (nonatomic, assign) BOOL  transitionInProgress;

- (void)attachToViewController:(UIViewController *)viewController;

@end
