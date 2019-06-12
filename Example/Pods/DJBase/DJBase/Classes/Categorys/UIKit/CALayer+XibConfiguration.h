//
//  CALayer+XibConfiguration.h
//  CPS
//
//  Created by dj-xxzx-10065 on 15/12/15.
//  Copyright © 2015年 dj-xxzx-10065. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer(XibConfiguration)

// This assigns a CGColor to borderColor.
@property(nonatomic, assign) UIColor* borderUIColor;

@end
