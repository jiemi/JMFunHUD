//
//  JMFunHUD.m
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//



#import "JMFunHUD.h"
#import "JMSimpleLoader.h"
#import "AppDelegate.h"

@interface JMFunHUD()

@property (nonatomic, strong) UIVisualEffectView *blurView;

@property (nonatomic, strong) JMSimpleLoader *indecatorView;

@end

@implementation JMFunHUD

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alpha = 0;
        [self setupViewsWith:JMFunHUDBackgroundTypeNone];
    }
    return self;
}
+ (JMFunHUD *)hudForView:(UIView *)view {
    
    JMFunHUD *hud = [[JMFunHUD alloc] initWithFrame:view.frame];
    [view addSubview:hud];
    return hud;
}
+ (JMFunHUD *)sharedHUD{
    
    static JMFunHUD * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[JMFunHUD alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    });
    return sharedInstance;
}




- (void)setBackgroundType:(JMFunHUDBackgroundType)backgroundType {
    _backgroundType = backgroundType;
    switch (backgroundType) {
        case  JMFunHUDBackgroundTypeNone:
            self.backgroundColor = [UIColor clearColor];
            _blurView.hidden = true;
            break;
        case JMFunHUDBackgroundTypeDim:
            self.backgroundColor = JMRGBA(0, 0, 0, 0.6);
            _blurView.hidden = true;
            break;
        case JMFunHUDBackgroundTypeBlur:
            self.blurView.hidden = false;
            self.backgroundColor = [UIColor clearColor];
            break;
        default:
            break;
    }
    
}
- (void)setupViewsWith:(JMFunHUDBackgroundType)type  {
    
    self.indecatorView = [[JMSimpleLoader alloc] initWithFrame:CGRectMake(0, 0, JMCircleRadius*2+30, JMCircleRadius*2+30)];
    
    _indecatorView.center = self.center;
    _indecatorView.layer.cornerRadius = 5;
    _indecatorView.layer.masksToBounds = true;
    _indecatorView.backgroundColor = JMRGBA(81, 88, 128, 0.8);
    
    self.blurView = [[UIVisualEffectView alloc] initWithFrame:self.frame];
    _blurView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    [self addSubview:self.blurView];
    
    switch (type) {
        case  JMFunHUDBackgroundTypeNone:
            _blurView.hidden = true;
            break;
        case JMFunHUDBackgroundTypeDim:
            self.backgroundColor = JMRGBA(0, 0, 0, 0.6);
            _blurView.hidden = true;
            break;
        case JMFunHUDBackgroundTypeBlur:
            break;
        default:
            break;
    }
    
    [self addSubview:_indecatorView];
    
}


- (void)show:(BOOL)animated {
    
    NSAssert(self.superview, @"JMFundHud should have a superview");
    
    if(animated) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.alpha = 1;
        } completion:^(BOOL completed){
            
        }];
    } else {
        self.alpha = 1;
    }
}

- (void)hide:(BOOL)animated {
    
    if (animated) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0;
        } completion:^(BOOL completed){
            [self removeFromSuperview];
            [self.indecatorView stopLoading];
        }];
    } else {
        self.alpha = 0;
        [self removeFromSuperview];
        [self.indecatorView stopLoading];
        
    }
    
}


+ (void)showSharedHUD:(BOOL)animated withType:(JMFunHUDBackgroundType)type {
    UIView *window = [UIApplication sharedApplication].windows.lastObject;
    JMFunHUD *sharedHUD = [JMFunHUD sharedHUD];
    sharedHUD.backgroundType = type;
    [window addSubview:sharedHUD];
    [sharedHUD show:animated];
}

+ (void)hideSharedHUD:(BOOL)animated {
    [[JMFunHUD sharedHUD]  hide:animated];
}

@end

