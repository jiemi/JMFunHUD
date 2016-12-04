//
//  JMCenterRotateView.h
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMDotView.h"
typedef void(^firstBallDidRestoreCallBack)(void);

@interface JMCenterRotateView : UIView

@property(nonatomic,strong)JMDotView *firstDot;

@property(nonatomic,strong)JMDotView *secondDot;

@property(nonatomic,strong)JMDotView *thirdDot;

@property(nonatomic,copy)firstBallDidRestoreCallBack dotAniationFinishHandler;


- (void)rotateAnimation;
- (void)removeAnimations;
@end
