//
//  LGEmitterLayer.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/21.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGEmitterLayer.h"
#import <UIKit/UIKit.h>

@implementation LGEmitterLayer

-(instancetype)init
{
    if (self = [super init]) {
        NSString *file = [[NSBundle bundleForClass:[self class]] pathForResource:@"LGAnimation.bundle/TwinkleImage" ofType:@"png"];
        
        CAEmitterCell *cell1 = [[CAEmitterCell alloc] init];
        CAEmitterCell *cell2 = [[CAEmitterCell alloc] init];
        
        NSArray *cells = @[cell1, cell2];
        for (CAEmitterCell *cell in cells) {
            cell.birthRate = 8.0;
            cell.lifetime = 1.25;
            cell.lifetimeRange = 0;
            cell.emissionRange = (CGFloat)(M_PI_4);
            cell.velocity = 2.0;
            cell.velocityRange = 18.0;
            cell.scale = 0.65;
            cell.scaleRange = 0.7;
            cell.scaleSpeed = 0.6;
            cell.spin = 0.9;
            cell.spinRange = (CGFloat)(M_PI);
            cell.color = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
            cell.alphaSpeed = -0.8;
            cell.contents = [UIImage imageWithContentsOfFile:file];
            cell.magnificationFilter = @"linear";
            cell.minificationFilter = @"trilinear";
            cell.enabled = YES;
        }
        self.emitterCells = cells;
        
        self.emitterPosition = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        self.emitterSize = self.bounds.size;
        
        self.emitterShape = @"circle";
        self.emitterMode  = @"surface";
        self.renderMode = @"unordered";
    }
    return self;
}

- (CGPoint)randomPoint:(CGFloat)range
{
    CGFloat x = -range + (arc4random_uniform(1000) / 1000) * 2.0 *range;
    CGFloat y = -range + (arc4random_uniform(1000) / 1000) * 2.0 *range;
    
    return CGPointMake(x, y);
}

- (void)addPositionAnimation
{
    [CATransaction begin];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 0.35;
    animation.additive = YES;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.beginTime = (CFTimeInterval)((arc4random_uniform(1000) + 1) * 0.2 * 0.5);
    
    animation.values = @[[NSValue valueWithCGPoint:[self randomPoint:0.25]],
                         [NSValue valueWithCGPoint:[self randomPoint:0.25]],
                         [NSValue valueWithCGPoint:[self randomPoint:0.25]],
                         [NSValue valueWithCGPoint:[self randomPoint:0.25]],
                         [NSValue valueWithCGPoint:[self randomPoint:0.25]]];
    [self addAnimation:animation forKey:animation.keyPath];
    [CATransaction commit];
}


- (void)addRotationAnimation
{
    [CATransaction begin];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.35;
    animation.valueFunction = [CAValueFunction functionWithName:kCAValueFunctionRotateZ];
    animation.additive = YES;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    animation.beginTime = (CFTimeInterval)((arc4random_uniform(1000) + 1)* 0.2 * 0.5);
    CGFloat value = 0.104;
    animation.values = @[@(-value), @(value), @(-value)];
    [self addAnimation:animation forKey:animation.keyPath];
    [CATransaction commit];
}


- (void)addFadeInOutAnimation:(CFTimeInterval)beginTime
{
    [CATransaction begin];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = 0;
    animation.toValue = @(1.0);
    animation.repeatCount = 2;
    animation.autoreverses = true;
    animation.duration = 0.4;
    animation.fillMode = kCAFillModeForwards;
    animation.beginTime = beginTime;
    [CATransaction setCompletionBlock:^{
        [self removeFromSuperlayer];
    }];
    [CATransaction commit];
}



@end
