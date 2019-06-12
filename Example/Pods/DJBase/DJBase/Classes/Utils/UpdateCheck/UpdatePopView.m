//
//  UpdatePopView.m
//  BI
//
//  Created by zhangsp on 2017/12/7.
//  Copyright © 2017年 DJKJ. All rights reserved.
//

#import "UpdatePopView.h"
//#import "UIColor+expanded.h"
#import <Masonry/Masonry.h>
#define HScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define HScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define SheetHeight HScreenHeight*0.58
#define LeftSpace   43
#define RightSpace  31

@interface UpdatePopView()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *mainView;

@property (nonatomic, weak) UIView *topView;
@property (nonatomic, weak) UIView *centerView;
@property (nonatomic, weak) UIView *bottomView;

@property (nonatomic, weak) UILabel *messageLabel;
@property (nonatomic, weak) UIButton *updateButton;
@property (nonatomic, weak) UIButton *cancelButton;

@property (nonatomic, weak) NSString *messageText;
@property (nonatomic, weak) NSString *cancelText;
@property (nonatomic, weak) NSString *titleText;

@end

@implementation UpdatePopView


- (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    NSBundle *imageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resource" ofType:@"bundle"]];
    name = [name stringByAppendingString:@"@2x"];
    NSString *imagePath = [imageBundle pathForResource:name ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    if (!image) {
        // 兼容业务方自己设置图片的方式
        name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        image = [UIImage imageNamed:name];
    }
    return image;
}

#pragma mark - 初始化
- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText delegate:(id<UpdatePopupDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        self.messageText = message;
        self.cancelText = cancelText;
        
        [self initSubview];
        [self initControl];
        
        BOOL cancel = [cancelText boolValue];
        if (!cancel) {
            self.cancelButton.hidden = YES;
            self.cancelButton.enabled = NO;
        }
    }
    return self;
}
- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock {
    if (self = [super init]) {
        self.updateClickBlock = updateClickBlock;
        self.messageText = message;
        self.cancelText = cancelText;
        
        [self initSubview];
        [self initControl];
        
        BOOL cancel = [cancelText boolValue];
        if (cancel) {
            self.cancelButton.hidden = YES;
            self.cancelButton.enabled = NO;
        }
    }
    return self;
}

- (id)initWithStyle:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock cancelBlock:(CancelClickBlock)cancelClickBlock
{
    if (self = [super init]) {
        self.updateClickBlock = updateClickBlock;
        self.cancelClickBlock = cancelClickBlock;
        self.messageText = message;
        self.cancelText = cancelText;
        
        [self initSubview];
        [self initControl];
        
        BOOL cancel = [cancelText boolValue];
        if (cancel) {
            self.cancelButton.hidden = YES;
            self.cancelButton.enabled = NO;
        }
    }
    return self;
}


- (id)initWithStyleTitle:(NSString *)titleText message:(NSString *)message cancelText:(NSString *)cancelText updateBlock:(UpdateClickBlock)updateClickBlock cancelBlock:(CancelClickBlock)cancelClickBlock{
    if (self = [super init]) {
        self.updateClickBlock = updateClickBlock;
        self.cancelClickBlock = cancelClickBlock;
        self.messageText = message;
        self.cancelText = cancelText;
        self.titleText = titleText;
        [self initSubview];
        [self initControl];
        
        /// 1 隐藏 0 显示.
        BOOL cancel = [cancelText boolValue];
        if (cancel) {
            self.cancelButton.hidden = YES;
            self.cancelButton.enabled = NO;
        }
    }
    return self;
}

#pragma mark - 初始化布局
- (void)initSubview {
    self.frame = [self getCurrentWindowView].frame;
    [[self getCurrentWindowView] addSubview:self];
    UIView *mainView = [UIView new];
    mainView.center = CGPointMake(HScreenWidth/2, HScreenHeight/2);
    mainView.bounds = CGRectMake(0, 0, HScreenWidth-LeftSpace-RightSpace, SheetHeight);
    mainView.backgroundColor = [UIColor clearColor];
    [self addSubview:mainView];
    self.mainView = mainView;
}

#pragma mark - 初始化控件
- (void)initControl {
    //内容view
    UIView *view = [UIView new];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5;
    view.clipsToBounds = YES;
    [view setBackgroundColor:[UIColor whiteColor]];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(1, 5);
    view.layer.shadowOpacity = 0.2;
    [self.mainView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self->_mainView);
        make.right.equalTo(self->_mainView.mas_right).with.offset(-7);
        make.top.equalTo(self->_mainView.mas_top).with.offset(7);
    }];
    
    //头部视图
    UIView *topview = [UIView new];
    [topview setBackgroundColor:[UIColor clearColor]];
    [view addSubview:topview];
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(view);
        //381
        make.height.mas_equalTo(self->_mainView.frame.size.height*0.4);
    }];
    self.topView = topview;
    
    UIImageView *imageView = [UIImageView new];
    [imageView setImage:[self imageNamedFromMyBundle:@"popup_bg_top"]];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self->_topView);
    }];
    // logo
    UIImageView *logoImageView = [UIImageView new];
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    
    
    [logoImageView setImage:[self imageNamedFromMyBundle:icon]];
    [logoImageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_topView).offset(10);
        make.centerX.mas_equalTo(self->_topView.mas_centerX);
        make.height.mas_equalTo(@75);
    }];
    // 发现新版本
    UILabel *label = [[UILabel alloc] init];
    label.text = self.titleText.length>0? [NSString stringWithFormat:@"版本更新%@", self.titleText] :@"版本更新";
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor whiteColor];
    [imageView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self->_topView.mas_centerX);
    }];
    
    //取消
    UIButton *cancelButton = [UIButton new];
    [cancelButton setImage:[self imageNamedFromMyBundle:@"common_btn_close"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(clickForCancelButton) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.alpha = 0;
    [self.mainView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self->_mainView);
        make.width.equalTo(@26);
        make.height.equalTo(@26);
    }];
    self.cancelButton = cancelButton;
    
    //底部按钮
    UIView *bottomview = [UIView new];
    [bottomview setBackgroundColor:[UIColor clearColor]];
    [view addSubview:bottomview];
    [bottomview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.equalTo(@65);
    }];
    self.bottomView = bottomview;
    
    UIImageView *bimageView = [UIImageView new];
    [bimageView setImage:[self imageNamedFromMyBundle:@"popup_bg_bottom"]];
    [bimageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.bottomView addSubview:bimageView];
    [bimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self->_bottomView);
    }];
    
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickForUpdate)];//响应方法没写
    bimageView.userInteractionEnabled=YES;   ///必须设置用户交互，手势才有用
    [bimageView addGestureRecognizer:tap];
    //中间视图
    UIView *centerView = [UIView new];
    centerView.clipsToBounds = YES;
    [view addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topview.mas_bottom);
        make.left.right.equalTo(view);
        make.bottom.equalTo(bottomview.mas_top);
    }];
    self.centerView = centerView;
    
    /// 最好可以滚动.
    UITextView *messageLabel = [UITextView new];
    messageLabel.editable = NO;
    messageLabel.selectable = NO;
    
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[_messageText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSPlainTextDocumentType } documentAttributes:nil error:nil];

    messageLabel.attributedText = attrStr;
    [messageLabel setFont:[UIFont systemFontOfSize:15.f]];
    [messageLabel setTextColor:[UIColor colorWithRed:((float) 51 / 255.0f) green:((float) 51 / 255.0f) blue:((float) 51 / 255.0f) alpha:1.0f]];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [self.centerView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_centerView.mas_top).with.offset(15);
        make.left.equalTo(self->_centerView.mas_left).with.offset(24);
        make.right.equalTo(self->_centerView.mas_right).with.offset(-25);
        make.bottom.equalTo(self->_centerView.mas_bottom).with.offset(-15);
    }];
}

#pragma mark - 更新按钮
- (void)clickForUpdate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didUpdateButton)]) {
        [self removeFromSuperview];
        [self.delegate didUpdateButton];
    }
    if (self.updateClickBlock) {
        self.updateClickBlock();
    }
}

#pragma mark - 取消按钮
- (void)clickForCancelButton {
    if (self.cancelClickBlock) {
        self.cancelClickBlock();
    }
    [self dismisView];
}

#pragma mark - 显示
- (void)show {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.mainView.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        CABasicAnimation* base=[self rotation:1.0 degree:2*M_PI repeatCount:1.0];
        [self.mainView.layer addAnimation:base forKey:@"rotation"];
        if (!self->_cancelButton.isHidden) {
            [UIView animateWithDuration:0.5 delay:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                self.cancelButton.alpha = 1.0;
            } completion:nil];
        }
    }];
}

- (CABasicAnimation *)rotation:(float)dur degree:(float)degree  repeatCount:(int)repeatCount {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.duration=dur;
    theAnimation.cumulative= NO;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = @(0);
    theAnimation.toValue = @(degree);
    theAnimation.repeatCount=repeatCount;
    theAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    return  theAnimation;
}

#pragma mark - 触摸消失
- (void)dismisView {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.mainView.transform=CGAffineTransformScale(self.mainView.transform, 0.001f, 0.001f);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 当前视图
- (UIWindow *)getCurrentWindowView{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    
    if(window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication]windows];
        for(UIWindow *tmpWin in windows){
            if(tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    return window;
}
@end

