//
//  JMCenterRotateView.m
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//



#import "JMCenterRotateView.h"
#import "JMSimpleLoader.h"

@implementation JMCenterRotateView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpDotViews];
        //[self firstDotMoveAnimation];
        // self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setUpDotViews {
    self.firstDot = [JMDotView layer];
    self.secondDot = [JMDotView layer];
    self.thirdDot = [JMDotView layer];
    
    
    
    [self.layer addSublayer:_firstDot];
    [self.layer addSublayer:_secondDot];
    [self.layer addSublayer:_thirdDot];
    
    CGFloat dotWidth = self.frame.size.width * 3 / 4 / 2;
    
    CGRect firstDotFrame = CGRectMake(0, 0, dotWidth, dotWidth);
    CGRect secondDotFrame = CGRectMake(0, self.frame.size.height-dotWidth, dotWidth, dotWidth);
    CGRect thirdDotFrame = CGRectMake(self.frame.size.width-dotWidth, secondDotFrame.origin.y, dotWidth, dotWidth);
    
    self.firstDot.frame = firstDotFrame;
    self.secondDot.frame = secondDotFrame;
    self.thirdDot.frame = thirdDotFrame;
    
    
}

- (void)rotateAnimation {
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0.0);
    rotateAnimation.toValue = @(M_PI/2);
    rotateAnimation.duration =  JMRotateAnimationTime;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = false;
    rotateAnimation.delegate = self;
    [rotateAnimation setValue:@"rotateAnimation" forKey:@"animationName"];
    [self.layer addAnimation:rotateAnimation forKey:nil];
    
}

- (void)removeAnimations {
    [self.layer removeAllAnimations];
    [[self firstDot] removeAllAnimations];
}

- (void)firstDotMoveAnimation {
    CGFloat endX = self.frame.size.width - self.firstDot.frame.size.width+self.firstDot.frame.size.width/2;
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnimation.toValue = [[NSNumber alloc] initWithFloat:endX];
    moveAnimation.fromValue = @(self.firstDot.frame.size.width/2);
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    // moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.duration = JMFirstDotMoveAnimationTime;
    // moveAnimation.repeatCount = 1000;
    //  moveAnimation.removedOnCompletion = false;
    //  [self.firstDot addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    
    CABasicAnimation *changeAnimation = [CABasicAnimation animationWithKeyPath:@"factor"];
    changeAnimation.toValue = @(1);
    changeAnimation.fromValue = @(0);
    changeAnimation.fillMode = kCAFillModeForwards;
    changeAnimation.duration = JMFirstDotMoveAnimationTime;
    //  changeAnimation.delegate = self ;
    //  changeAnimation.repeatCount = 1;
    //  changeAnimation.removedOnCompletion = false;
    
    //   [self.firstDot addAnimation:changeAnimation forKey:@"changeAnimation"];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[moveAnimation,changeAnimation];
    group.duration = JMFirstDotMoveAnimationTime;
    group.removedOnCompletion = false;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    group.beginTime = [self.firstDot convertTime:CACurrentMediaTime() toLayer:nil] + 0.1;
    [group setValue:@"firstDotGroup" forKey:@"animationName"];
    [self.firstDot addAnimation:group forKey:@"firstDotGroup"];
    
    
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSString *animationName = [anim valueForKey:@"animationName"];
    if ([animationName isEqualToString:@"rotateAnimation"] ) {
        [self firstDotMoveAnimation];
    }
    else if ([animationName isEqualToString:@"firstDotGroup"] ) {
        
        self.firstDot.factor = 1;
        self.firstDot.frame = CGRectMake(self.frame.size.width - self.firstDot.frame.size.width, self.firstDot.frame.origin.y, self.firstDot.frame.size.width, self.firstDot.frame.size.height);
        [self firstDotRestoreAnimation];
        
    } else if ([animationName isEqualToString:@"restoreAnimation"] ) {
        [self.layer removeAllAnimations];
        [self.firstDot removeAllAnimations];
        self.firstDot.factor = 0;
        [self restoreFirstDotPosition];
        
        __weak typeof(self) weakSelf = self ;
        dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC *200);
        dispatch_after(delay, dispatch_get_main_queue(), ^{
            if(weakSelf != nil) {
                weakSelf.dotAniationFinishHandler();
            }
        });
        
    }
}

-(void)firstDotRestoreAnimation {
    [self.firstDot removeAnimationForKey:@"firstDotGroup"];
    NSMutableArray *values = [self springAnimationValues:@(1) toValue:@(0) usingSpringWithDamping:4 initialSpringVelocity:10 duration:JMFirstDotRestoreAnimationTime];
    CAKeyframeAnimation *restoreAnimation = [CAKeyframeAnimation animationWithKeyPath:@"factor"];
    restoreAnimation.values = values;
    restoreAnimation.duration = JMFirstDotRestoreAnimationTime;
    restoreAnimation.fillMode = kCAFillModeForwards;
    restoreAnimation.removedOnCompletion = false;
    restoreAnimation.delegate = self ;
    [restoreAnimation setValue:@"restoreAnimation" forKey:@"animationName"];
    [self.firstDot addAnimation:restoreAnimation forKey:@"restoreAnimation"];
    
}

- (void)restoreFirstDotPosition {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.firstDot.frame = CGRectMake(0, self.firstDot.frame.origin.y, self.firstDot.frame.size.width, self.firstDot.frame.size.height);
    [CATransaction commit];
    
}

- (NSMutableArray *)springAnimationValues:(id)fromValue
                                  toValue:(id)toValue
                   usingSpringWithDamping:(CGFloat)damping
                    initialSpringVelocity:(CGFloat)velocity
                                 duration:(CGFloat)duration {
    // 60个关键帧
    NSInteger numOfFrames = duration * 60;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:numOfFrames];
    for (NSInteger i = 0; i < numOfFrames; i++) {
        [values addObject:@(0.0)];
    }
    
    //差值
    CGFloat diff = [toValue floatValue] - [fromValue floatValue];
    for (NSInteger frame = 0; frame < numOfFrames; frame++) {
        CGFloat x = (CGFloat)frame / (CGFloat)numOfFrames;
        CGFloat value = [toValue floatValue] -
        diff * (pow(M_E, -damping * x) *
                cos(velocity * x)); // y = 1-e^{-5x} * cos(30x)
        values[frame] = @(value);
    }
    return values;
}
@end
