//
//  DJCenterButton.h
//  DJBase
//  中间按钮
//  Created by CSS on 2019/5/20.
//  Copyright © 2019年 djkj. All rights reserved.
//

#import "DJTabBarConfig.h"
#define BULGEH 16   //button bulge of height

@interface DJCenterButton : UIButton
/** Whether center button to bulge */
@property(assign , nonatomic,getter=is_bulge) BOOL bulge;
@end
