
//
//  JMFunHUD.h
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JMFunHUDBackgroundType) {
    JMFunHUDBackgroundTypeNone,
    JMFunHUDBackgroundTypeDim,
    JMFunHUDBackgroundTypeBlur,
};
@interface JMFunHUD : UIView

@property (nonatomic, assign) JMFunHUDBackgroundType backgroundType;


+ (JMFunHUD *)hudForView:(UIView *)view;

+ (JMFunHUD *)sharedHUD;

- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;


+ (void)showSharedHUD:(BOOL)animated withType:(JMFunHUDBackgroundType)type;
+ (void)hideSharedHUD:(BOOL)animated;

@end
