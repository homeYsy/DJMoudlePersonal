//
//  HButton.m
//  CPS
//
//  Created by dj-xxzx-10065 on 15/11/5.
//  Copyright © 2015年 dj-xxzx-10065. All rights reserved.
//

#import "HButton.h"
#import "PulsingHaloLayer.h"

@implementation HButton

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint currentTouch = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, currentTouch)) {
        PulsingHaloLayer *layer = [PulsingHaloLayer new];
        layer.radius = self.bounds.size.width;
        layer.animationDuration = MIN(1.0f, MAX(self.bounds.size.width/250.0f, 0.6f));
        layer.fromValueForRadius = 0.03f;
        layer.repeatCount = 1;
        layer.backgroundColor = [self.titleLabel textColor].CGColor;
        layer.position = currentTouch;
        [self.layer addSublayer:layer];
        [self.layer setMasksToBounds:YES];
        
        [self performSelector:@selector(sendAction) withObject:nil afterDelay:.3f];
    }
}

- (void)sendAction
{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

@end
