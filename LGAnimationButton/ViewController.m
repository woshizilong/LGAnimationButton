//
//  ViewController.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/21.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "LGAnimatedTransitioning.h"
#import "LGDismissAnimatedTransitioning.h"
#import "LGNavigationAnimationTransitioning.h"
#import "LGInteractiveTransition.h"

@interface ViewController () <UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) LGAnimatedTransitioning *animatonTransition;
@property (nonatomic, strong) LGDismissAnimatedTransitioning *disAnimationTransition;
@property (nonatomic, strong) LGNavigationAnimationTransitioning *navAnimationTransition;
@property (nonatomic, strong) LGInteractiveTransition *customInteractiveTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.animatonTransition = [[LGAnimatedTransitioning alloc] init];
    self.disAnimationTransition = [[LGDismissAnimatedTransitioning alloc] init];
    
    self.navAnimationTransition = [[LGNavigationAnimationTransitioning alloc] init];
    self.navigationController.delegate = self;
    
    self.customInteractiveTransition = [[LGInteractiveTransition alloc] init];
}

- (IBAction)click:(id)sender {
    TestViewController *ctrl = [[TestViewController alloc] init];
    ctrl.transitioningDelegate = self;
    [self presentViewController:ctrl animated:YES completion:nil];
}
- (IBAction)push:(id)sender {
    TestViewController *ctrl =  [[TestViewController alloc] init];

    [self.navigationController pushViewController:ctrl animated:YES];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.animatonTransition;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.disAnimationTransition;
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        [self.customInteractiveTransition attachToViewController:toVC];
    }
    self.navAnimationTransition.reverse = operation == UINavigationControllerOperationPop;
    return self.navAnimationTransition;
}

-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.customInteractiveTransition.transitionInProgress? self.customInteractiveTransition : nil;
}

@end
