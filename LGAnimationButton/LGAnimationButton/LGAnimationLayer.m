//
//  LGAnimationLayer.m
//  LGAnimationButton
//
//  Created by jamy on 15/9/21.
//  Copyright © 2015年 jamy. All rights reserved.
//

#import "LGAnimationLayer.h"

@implementation LGAnimationLayer

-(instancetype)initWithFrame:(CGRect)rect
{
    if (self = [super init]) {
        self.frame = rect;
        CGFloat radius = (rect.size.height / 2) * 0.5;
        CGPoint center = CGPointMake(rect.size.height / 2, self.bounds.size.width / 2);
        
        self.path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:(float)(0 - M_PI_2) endAngle:(float)(M_PI *2 - M_PI_2) clockwise:YES].CGPath;
        
        self.fillColor = [UIColor blackColor].CGColor;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.strokeEnd = 0.3f;
        self.lineWidth = 2.0f;
        self.hidden = YES;
    }
    return self;
}


- (void)beginAnimation
{
    self.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:(float)(M_PI * 2)];
    animation.duration = .7f;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    
    [self addAnimation:animation forKey:animation.keyPath];
}

- (void)stopAnimation
{
    self.hidden = YES;
    [self removeAllAnimations];
}

@end
