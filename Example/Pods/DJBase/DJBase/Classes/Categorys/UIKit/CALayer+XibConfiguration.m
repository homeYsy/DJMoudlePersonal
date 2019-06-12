//
//  CALayer+XibConfiguration.m
//  CPS
//
//  Created by dj-xxzx-10065 on 15/12/15.
//  Copyright © 2015年 dj-xxzx-10065. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
