//
//  JMSimpleLoader.m
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//


#import "JMSimpleLoader.h"
#import "JMCenterRotateView.h"
@interface JMSimpleLoader() {
    double first_Circle_Stage1_StrokeEnd;
    double first_Circle_Stage2_StrokeEnd;
    double first_Circle_Stage3_StrokeEnd;
    double first_Circle_Stage4_StrokeEnd;
    
    double first_Circle_Stage1_StrokeStart;
    double first_Circle_Stage2_StrokeStart;
    double first_Circle_Stage3_StrokeStart;
    double first_Circle_Stage4_StrokeStart;
    
    double second_Circle_Stage1_StrokeEnd;
    double second_Circle_Stage2_StrokeEnd;
    double second_Circle_Stage3_StrokeEnd;
    double second_Circle_Stage4_StrokeEnd;
    
    double second_Circle_Stage1_StrokeStart;
    double second_Circle_Stage2_StrokeStart;
    double second_Circle_Stage3_StrokeStart;
    double second_Circle_Stage4_StrokeStart;
    
    double third_Circle_Stage3_StrokeEnd;
    double third_Circle_Stage4_StrokeEnd;
    
    double third_Circle_Stage3_StrokeStart;
    double third_Circle_Stage4_StrokeStart;
}
@property(nonatomic,strong) JMCenterRotateView *rotateView;
@property(nonatomic,strong) CAAnimationGroup *firstCircleAnimationGroup;
@property(nonatomic,strong) CAAnimationGroup *secondCircleAnimationGroup;


@end
@implementation JMSimpleLoader

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpStageValues];
        [self setUpRotateView];
        [self startLoading];
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}



- (void)startLoading {
    [self removeLines];
    [self creatFirstThreePathLayer];
    [self creatSecondThreePathLayer];
    
}

- (void)stopLoading {
    [self.rotateView removeAnimations];
    [self removeLines];
    /*  NSArray *sublayers = [self.layer sublayers];
     for(CALayer *layer in sublayers) {
     [layer removeAllAnimations];
     [layer removeFromSuperlayer];
     }*/
}

- (void)removeLines {
    NSArray *sublayers = [self.layer sublayers];
    NSInteger count = sublayers.count;
    for(NSInteger i = 0;i < count;) {
        id layer = sublayers[i];
        if ([layer isKindOfClass:[CAShapeLayer class]]) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
            count -= 1;
        } else {
            i++;
        }
    }
    
}

- (void)setUpRotateView {
    
    CGFloat rotateViewWidth = JMCircleRadius + 10;
    CGFloat rotateViewHeight = rotateViewWidth;
    CGFloat rotateX = (self.frame.size.width - rotateViewWidth)/2;
    CGFloat rotateY = (self.frame.size.height - rotateViewHeight)/2;
    
    self.rotateView = [[JMCenterRotateView alloc] initWithFrame:CGRectMake(rotateX, rotateY, rotateViewWidth, rotateViewHeight)];
    __weak typeof(self) weakSelf = self ;
    self.rotateView.dotAniationFinishHandler = ^{
        [weakSelf startLoading];
    };
    [self addSubview:self.rotateView];
}



- (void)setUpStageValues {
    
    double s1 = JMFirstCircleLength;
    double s2 = JMSecondCircleLength;
    double s3 = JMThirdCircleLength;
    
    first_Circle_Stage1_StrokeEnd = (M_PI+M_PI/8)/s1;
    first_Circle_Stage2_StrokeEnd = (4*M_PI-M_PI*1/3)/s1;
    first_Circle_Stage3_StrokeEnd = (4*M_PI+M_PI/6)/s1;
    first_Circle_Stage4_StrokeEnd = 1;
    
    first_Circle_Stage1_StrokeStart = (M_PI/2-M_PI/6)/s1;
    first_Circle_Stage2_StrokeStart = (2*M_PI + M_PI/6)/s1; //同时也是白线起点
    first_Circle_Stage3_StrokeStart = (4*M_PI-M_PI/6)/s1;
    first_Circle_Stage4_StrokeStart = (s1-M_PI/30)/s1;//1;
    
    second_Circle_Stage1_StrokeEnd = (M_PI+M_PI/8-M_PI/12)/s2;
    second_Circle_Stage2_StrokeEnd = (4*M_PI-M_PI*1/3-M_PI/3)/s2;
    second_Circle_Stage3_StrokeEnd = (4*M_PI-M_PI/6)/s2;
    second_Circle_Stage4_StrokeEnd = (4 * M_PI )/s2;
    
    second_Circle_Stage1_StrokeStart = (M_PI/2-M_PI/6)/s2;
    second_Circle_Stage2_StrokeStart = (2*M_PI + M_PI/6)/s2;; //同时也是白线起点
    second_Circle_Stage3_StrokeStart = (4*M_PI-M_PI/6-M_PI/3)/s2;
    second_Circle_Stage4_StrokeStart = (4 * M_PI-M_PI/30)/s2;//(4 * M_PI )/s2;
    
    third_Circle_Stage3_StrokeEnd = (M_PI*5/4)/s3;
    third_Circle_Stage4_StrokeEnd = 1;
    
    third_Circle_Stage3_StrokeStart = (M_PI*5/4-M_PI/3)/s3;
    third_Circle_Stage4_StrokeStart = (s3 - M_PI/30)/s3;//1;
    
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *animationName = [anim valueForKey:@"animationName"];
    if ([animationName isEqualToString:@"firstCircleGroup"]) {
        
    } else if ([animationName isEqualToString:@""]) {
        
    }
}
/**
 *  毫秒
 *
 *  @param mscDelay 毫秒
 */
- (void)startRotateAfterSeconds:(int) mscDelay {
    __weak typeof(self) weakSelf = self ;
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC *mscDelay);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [weakSelf.rotateView rotateAnimation];
    });
}

- (void)creatFirstThreePathLayer {
    CAShapeLayer *firstCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:firstCirlce];
    
    CAShapeLayer *secondCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:secondCirlce];
    
    CAShapeLayer *thirdCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:thirdCirlce];
    
    /**
     *   绿线
     */
    UIBezierPath *firstCirlcePath = [self creatCirclePathWithRadius:JMCircleRadius startAngle:JMFirstCircelStartAngle endAngle:JMFirstCircelEndAngle];
    firstCirlce.strokeColor = JMRGBA(144, 241, 9, 1).CGColor;
    firstCirlce.fillColor = [UIColor clearColor].CGColor;
    firstCirlce.lineWidth = JMStrokeWidth;
    firstCirlce.contentsScale = [UIScreen mainScreen].scale;
    firstCirlce.lineCap = kCALineCapRound;
    firstCirlce.path = firstCirlcePath.CGPath;
    firstCirlce.strokeEnd = 0;
    firstCirlce.strokeStart = 0;
    
    NSArray<NSNumber*>* firstCirlce_StrokeEnd_Values = [self create_Fast_First_Cirlce_StrokeEnd_Values];
    NSArray<NSNumber*>* firstCirlceTimes = [self create_Fast_CirlceTimes];
    NSArray<NSNumber*>* firstCirlce_StrokeStart_Values = [self create_Fast_First_Cirlce_StrokeStart_Values];
    
    CAKeyframeAnimation *firstCircle_StrokeEnd_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    firstCircle_StrokeEnd_Animation.values = firstCirlce_StrokeEnd_Values;
    firstCircle_StrokeEnd_Animation.keyTimes = firstCirlceTimes;
    firstCircle_StrokeEnd_Animation.duration = JMLineAnimationTime;
    
    
    CAKeyframeAnimation *firstCircle_StrokeStart_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    firstCircle_StrokeStart_Animation.values = firstCirlce_StrokeStart_Values;
    firstCircle_StrokeStart_Animation.keyTimes = firstCirlceTimes;
    firstCircle_StrokeStart_Animation.duration = JMLineAnimationTime;
    
    CAAnimationGroup *firstCircleGroup = [CAAnimationGroup animation];
    firstCircleGroup.animations = @[firstCircle_StrokeStart_Animation,firstCircle_StrokeEnd_Animation];
    firstCircleGroup.duration = JMLineAnimationTime;
    firstCircleGroup.delegate = self ;
    //  firstCircleGroup.removedOnCompletion = true;
    // firstCircleGroup.repeatCount = MAXFLOAT;
    [firstCircleGroup setValue:@"firstCircleGroup" forKey:@"animationName"];
    [firstCirlce addAnimation:firstCircleGroup forKey:nil];
    
    
    /**
     *   黄线
     */
    UIBezierPath *secondCirlcePath = [self creatCirclePathWithRadius:JMCircleRadius startAngle:JMSecondCircelStartAngle endAngle:JMSecondCircelEndAngle];
    secondCirlce.strokeColor = JMRGBA(253, 184, 9, 1).CGColor;
    secondCirlce.fillColor = [UIColor clearColor].CGColor;
    secondCirlce.lineWidth = JMStrokeWidth;
    secondCirlce.contentsScale = [UIScreen mainScreen].scale;
    secondCirlce.lineCap = kCALineCapRound;
    secondCirlce.path = secondCirlcePath.CGPath;
    secondCirlce.strokeEnd = 0;
    secondCirlce.strokeStart = 0;
    
    
    NSArray<NSNumber*>* secondCirlce_StrokeEnd_Values = [self create_Fast_Second_Cirlce_StrokeEnd_Values];
    NSArray<NSNumber*> *secondCirlce_StrokeStart_Values = [self create_Fast_Second_Cirlce_StrokeStart_Values];
    NSArray<NSNumber*> *secondCirlceTimes = firstCirlceTimes.copy;
    
    CAKeyframeAnimation *secondCircle_StrokeEnd_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    secondCircle_StrokeEnd_Animation.values = secondCirlce_StrokeEnd_Values;
    secondCircle_StrokeEnd_Animation.keyTimes = secondCirlceTimes;
    secondCircle_StrokeEnd_Animation.duration = JMLineAnimationTime;
    
    
    CAKeyframeAnimation *secondCircle_StrokeStart_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    secondCircle_StrokeStart_Animation.values = secondCirlce_StrokeStart_Values;
    secondCircle_StrokeStart_Animation.keyTimes = secondCirlceTimes;
    secondCircle_StrokeStart_Animation.duration = JMLineAnimationTime;
    
    
    CAAnimationGroup *secondCircleGroup = [CAAnimationGroup animation];
    secondCircleGroup.animations = @[secondCircle_StrokeEnd_Animation,secondCircle_StrokeStart_Animation];
    secondCircleGroup.duration = JMLineAnimationTime;
    secondCircleGroup.delegate = self ;
    // secondCircleGroup.removedOnCompletion = true;
    // secondCircleGroup.repeatCount = MAXFLOAT;
    //  [secondCircleGroup setValue:@"firstCircleGroup" forKey:@"animationName"];
    [secondCirlce addAnimation:secondCircleGroup forKey:nil];
    
    [self startRotateAfterSeconds:JMLineAnimationTime * 0.2*1000];
    
}



- (void) creatSecondThreePathLayer {
    CAShapeLayer *firstCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:firstCirlce];
    
    CAShapeLayer *secondCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:secondCirlce];
    
    CAShapeLayer *thirdCirlce = [CAShapeLayer layer];
    [self.layer addSublayer:thirdCirlce];
    
    /**
     *   绿线
     */
    UIBezierPath *firstCirlcePath = [self creatCirclePathWithRadius:JMCircleRadius startAngle:JMFirstCircelStartAngle endAngle:JMFirstCircelEndAngle];
    firstCirlce.strokeColor = JMRGBA(144, 241, 9, 1).CGColor;
    firstCirlce.fillColor = [UIColor clearColor].CGColor;
    firstCirlce.lineWidth = JMStrokeWidth;
    firstCirlce.contentsScale = [UIScreen mainScreen].scale;
    firstCirlce.lineCap = kCALineCapRound;
    firstCirlce.path = firstCirlcePath.CGPath;
    firstCirlce.strokeEnd = 0;
    firstCirlce.strokeStart = 0;
    
    NSArray<NSNumber*>* firstCirlce_StrokeEnd_Values = [self create_Slow_First_Cirlce_StrokeEnd_Values];
    NSArray<NSNumber*>* firstCirlceTimes = [self create_Slow_CirlceTimes];
    NSArray<NSNumber*>* firstCirlce_StrokeStart_Values = [self create_Slow_First_Cirlce_StrokeStart_Values];
    
    CAKeyframeAnimation *firstCircle_StrokeEnd_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    firstCircle_StrokeEnd_Animation.values = firstCirlce_StrokeEnd_Values;
    firstCircle_StrokeEnd_Animation.keyTimes = firstCirlceTimes;
    firstCircle_StrokeEnd_Animation.duration = JMLineAnimationTime;
    
    
    CAKeyframeAnimation *firstCircle_StrokeStart_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    firstCircle_StrokeStart_Animation.values = firstCirlce_StrokeStart_Values;
    firstCircle_StrokeStart_Animation.keyTimes = firstCirlceTimes;
    firstCircle_StrokeStart_Animation.duration = JMLineAnimationTime;
    
    CAAnimationGroup *firstCircleGroup = [CAAnimationGroup animation];
    firstCircleGroup.animations = @[firstCircle_StrokeStart_Animation,firstCircle_StrokeEnd_Animation];
    firstCircleGroup.duration = JMLineAnimationTime;
    firstCircleGroup.delegate = self ;
    // firstCircleGroup.removedOnCompletion = true;
    [firstCircleGroup setValue:@"secondCircleGroup" forKey:@"animationName"];
    //  firstCircleGroup.repeatCount = MAXFLOAT;
    [firstCirlce addAnimation:firstCircleGroup forKey:nil];
    
    
    /**
     *   黄线
     */
    UIBezierPath *secondCirlcePath = [self creatCirclePathWithRadius:JMCircleRadius startAngle:JMSecondCircelStartAngle endAngle:JMSecondCircelEndAngle];
    secondCirlce.strokeColor = JMRGBA(253, 184, 9, 1).CGColor;
    secondCirlce.fillColor = [UIColor clearColor].CGColor;
    secondCirlce.lineWidth = JMStrokeWidth;
    secondCirlce.contentsScale = [UIScreen mainScreen].scale;
    secondCirlce.lineCap = kCALineCapRound;
    secondCirlce.path = secondCirlcePath.CGPath;
    secondCirlce.strokeEnd = 0;
    secondCirlce.strokeStart = 0;
    
    
    NSArray<NSNumber*>* secondCirlce_StrokeEnd_Values = [self create_Slow_Second_Cirlce_StrokeEnd_Values];
    NSArray<NSNumber*> *secondCirlce_StrokeStart_Values = [self create_Slow_Second_Cirlce_StrokeStart_Values];
    NSArray<NSNumber*> *secondCirlceTimes = firstCirlceTimes.copy;
    
    CAKeyframeAnimation *secondCircle_StrokeEnd_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    secondCircle_StrokeEnd_Animation.values = secondCirlce_StrokeEnd_Values;
    secondCircle_StrokeEnd_Animation.keyTimes = secondCirlceTimes;
    secondCircle_StrokeEnd_Animation.duration = JMLineAnimationTime;
    
    
    CAKeyframeAnimation *secondCircle_StrokeStart_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    secondCircle_StrokeStart_Animation.values = secondCirlce_StrokeStart_Values;
    secondCircle_StrokeStart_Animation.keyTimes = secondCirlceTimes;
    secondCircle_StrokeStart_Animation.duration = JMLineAnimationTime;
    
    
    CAAnimationGroup *secondCircleGroup = [CAAnimationGroup animation];
    secondCircleGroup.animations = @[secondCircle_StrokeEnd_Animation,secondCircle_StrokeStart_Animation];
    secondCircleGroup.duration = JMLineAnimationTime;
    secondCircleGroup.delegate = self ;
    // secondCircleGroup.removedOnCompletion = true;
    //secondCircleGroup.repeatCount = MAXFLOAT;
    //[secondCircleGroup setValue:@"firstCircleGroup" forKey:@"animationName"];
    [secondCirlce addAnimation:secondCircleGroup forKey:nil];
    
    
    /**
     *   白线
     */
    UIBezierPath *thirdCirlcePath = [self creatCirclePathWithRadius:JMCircleRadius startAngle:JMThirdCircelStartAngle endAngle:JMthirdCircelEndAngle];
    thirdCirlce.strokeColor = [[UIColor whiteColor] CGColor];
    thirdCirlce.fillColor = [UIColor clearColor].CGColor;
    thirdCirlce.lineWidth = JMStrokeWidth;
    thirdCirlce.contentsScale = [UIScreen mainScreen].scale;
    thirdCirlce.lineCap = kCALineCapRound;
    thirdCirlce.path = thirdCirlcePath.CGPath;
    thirdCirlce.strokeEnd = 0;
    thirdCirlce.strokeStart = 0;
    
    NSArray<NSNumber*>* thirdCirlce_StrokeEnd_Values = [self create_Third_Cirlce_StrokeEnd_Values];
    NSArray<NSNumber*> *thirdCirlce_StrokeStart_Values = [self create_Third_Cirlce_StrokeStart_Values];
    NSArray<NSNumber*> *thirdCirlceTimes = firstCirlceTimes.copy;
    
    CAKeyframeAnimation *thirdCircle_StrokeEnd_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
    thirdCircle_StrokeEnd_Animation.values = thirdCirlce_StrokeEnd_Values;
    thirdCircle_StrokeEnd_Animation.keyTimes = thirdCirlceTimes;
    thirdCircle_StrokeEnd_Animation.duration = JMLineAnimationTime;
    
    
    CAKeyframeAnimation *thirdCircle_StrokeStart_Animation = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
    thirdCircle_StrokeStart_Animation.values = thirdCirlce_StrokeStart_Values;
    thirdCircle_StrokeStart_Animation.keyTimes = thirdCirlceTimes;
    thirdCircle_StrokeStart_Animation.duration = JMLineAnimationTime;
    
    
    CAAnimationGroup *thirdCircleGroup = [CAAnimationGroup animation];
    thirdCircleGroup.animations = @[thirdCircle_StrokeEnd_Animation,thirdCircle_StrokeStart_Animation];
    thirdCircleGroup.duration = JMLineAnimationTime;
    thirdCircleGroup.delegate = self ;
    // thirdCircleGroup.removedOnCompletion = true;
    //   thirdCircleGroup.repeatCount = MAXFLOAT;
    //  [thirdCircleGroup setValue:@"thirdCircleGroup" forKey:@"animationName"];
    [thirdCirlce addAnimation:thirdCircleGroup forKey:nil];
    
}



- (UIBezierPath*)creatCirclePathWithRadius: (double)radius startAngle:(double)startAngle
                                  endAngle:(double)endAngle {
    
    UIBezierPath *path ;
    path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:startAngle endAngle:endAngle  clockwise:YES];
    return path;
    
}

#pragma mark 第一个圈圈（快和慢）
- (NSArray<NSNumber*>*)create_Fast_First_Cirlce_StrokeEnd_Values {
    
    
    double firstCirlce_Stage0_StrokeEnd = 0;
    double firstCirlce_Stage1_StrokeEnd = first_Circle_Stage1_StrokeEnd;
    double firstCirlce_Stage2_StrokeEnd = first_Circle_Stage2_StrokeEnd;
    double firstCirlce_Stage3_StrokeEnd = first_Circle_Stage3_StrokeEnd;
    double firstCirlce_Stage4_StrokeEnd = first_Circle_Stage4_StrokeEnd;
    
    NSArray<NSNumber*>* firstCirlce_StrokeEnd_Values = @[@(firstCirlce_Stage0_StrokeEnd),
                                                         @(firstCirlce_Stage1_StrokeEnd),
                                                         @(firstCirlce_Stage2_StrokeEnd),
                                                         @(firstCirlce_Stage3_StrokeEnd),
                                                         @(firstCirlce_Stage4_StrokeEnd)];
    return firstCirlce_StrokeEnd_Values;
}

- (NSArray<NSNumber*>*)create_Fast_First_Cirlce_StrokeStart_Values {
    
    double firstCirlce_Stage0_StrokeStart = 0;
    double firstCirlce_Stage1_StrokeStart = first_Circle_Stage1_StrokeStart;
    double firstCirlce_Stage2_StrokeStart = first_Circle_Stage2_StrokeStart;
    double firstCirlce_Stage3_StrokeStart = first_Circle_Stage3_StrokeStart;
    double firstCirlce_Stage4_StrokeStart = first_Circle_Stage4_StrokeStart;
    
    NSArray<NSNumber*>* firstCirlce_StrokeStart_Values = @[@(firstCirlce_Stage0_StrokeStart),
                                                           @(firstCirlce_Stage1_StrokeStart),
                                                           @(firstCirlce_Stage2_StrokeStart),
                                                           @(firstCirlce_Stage3_StrokeStart),
                                                           @(firstCirlce_Stage4_StrokeStart)];
    return firstCirlce_StrokeStart_Values;
}

- (NSArray<NSNumber*>*)create_Fast_CirlceTimes {
    
    double firstCirlce_Stage0_Stroke_Time = 0.0/10;
    double firstCirlce_Stage1_Stroke_Time = 2.0/10;
    double firstCirlce_Stage2_Stroke_Time = (6.0)/10;
    double firstCirlce_Stage3_Stroke_Time = (8.1)/10;
    double firstCirlce_Stage4_Stroke_Time = (10.0)/10;
    
    NSArray<NSNumber*>* firstCirlceTimes = @[@(firstCirlce_Stage0_Stroke_Time),
                                             @(firstCirlce_Stage1_Stroke_Time),
                                             @(firstCirlce_Stage2_Stroke_Time),
                                             @(firstCirlce_Stage3_Stroke_Time),
                                             @(firstCirlce_Stage4_Stroke_Time)];
    
    return firstCirlceTimes;
}

- (NSArray<NSNumber*>*)create_Slow_First_Cirlce_StrokeEnd_Values {
    
    double firstCirlce_Stage0_StrokeEnd = 0;
    double firstCirlce_Stage1_StrokeEnd = 0;
    double firstCirlce_Stage2_StrokeEnd = first_Circle_Stage1_StrokeEnd;
    double firstCirlce_Stage3_StrokeEnd = first_Circle_Stage2_StrokeEnd;
    double firstCirlce_Stage4_StrokeEnd = first_Circle_Stage3_StrokeEnd;
    double firstCirlce_Stage5_StrokeEnd = first_Circle_Stage4_StrokeEnd;
    
    NSArray<NSNumber*>* firstCirlce_StrokeEnd_Values = @[@(firstCirlce_Stage0_StrokeEnd),
                                                         @(firstCirlce_Stage1_StrokeEnd),
                                                         @(firstCirlce_Stage2_StrokeEnd),
                                                         @(firstCirlce_Stage3_StrokeEnd),
                                                         @(firstCirlce_Stage4_StrokeEnd),
                                                         @(firstCirlce_Stage5_StrokeEnd)];
    return firstCirlce_StrokeEnd_Values;
}

- (NSArray<NSNumber*>*)create_Slow_CirlceTimes {
    
    double firstCirlce_Stage0_Stroke_Time = 0.0/10.0;
    double firstCirlce_Stage1_Stroke_Time = 1.0/10;
    double firstCirlce_Stage2_Stroke_Time = (3.0)/10;
    double firstCirlce_Stage3_Stroke_Time = (6.0)/10;
    double firstCirlce_Stage4_Stroke_Time = (8.1)/10;
    double firstCirlce_Stage5_Stroke_Time = (10.0)/10;
    
    NSArray<NSNumber*>* firstCirlceTimes = @[@(firstCirlce_Stage0_Stroke_Time),
                                             @(firstCirlce_Stage1_Stroke_Time),
                                             @(firstCirlce_Stage2_Stroke_Time),
                                             @(firstCirlce_Stage3_Stroke_Time),
                                             @(firstCirlce_Stage4_Stroke_Time),
                                             @(firstCirlce_Stage5_Stroke_Time)];
    
    return firstCirlceTimes;
}

- (NSArray<NSNumber*>*)create_Slow_First_Cirlce_StrokeStart_Values {
    
    double firstCirlce_Stage0_StrokeStart = 0;
    double firstCirlce_Stage1_StrokeStart = 0;
    double firstCirlce_Stage2_StrokeStart = first_Circle_Stage1_StrokeStart;
    double firstCirlce_Stage3_StrokeStart = first_Circle_Stage2_StrokeStart;
    double firstCirlce_Stage4_StrokeStart = first_Circle_Stage3_StrokeStart;
    double firstCirlce_Stage5_StrokeStart = first_Circle_Stage4_StrokeStart;
    
    NSArray<NSNumber*>* firstCirlce_StrokeStart_Values = @[@(firstCirlce_Stage0_StrokeStart),
                                                           @(firstCirlce_Stage1_StrokeStart),
                                                           @(firstCirlce_Stage2_StrokeStart),
                                                           @(firstCirlce_Stage3_StrokeStart),
                                                           @(firstCirlce_Stage4_StrokeStart),
                                                           @(firstCirlce_Stage5_StrokeStart)];
    return firstCirlce_StrokeStart_Values;
}

#pragma mark 第二个圈圈（快和慢）
- (NSArray<NSNumber*>*)create_Fast_Second_Cirlce_StrokeEnd_Values {
    
    
    double secondCirlce_Stage0_StrokeEnd = 0;
    double secondCirlce_Stage1_StrokeEnd = second_Circle_Stage1_StrokeEnd;
    double secondCirlce_Stage2_StrokeEnd = second_Circle_Stage2_StrokeEnd;
    double secondCirlce_Stage3_StrokeEnd = second_Circle_Stage3_StrokeEnd;
    double secondCirlce_Stage4_StrokeEnd = second_Circle_Stage4_StrokeEnd;
    
    NSArray<NSNumber*>* secondCirlce_StrokeEnd_Values = @[@(secondCirlce_Stage0_StrokeEnd),
                                                          @(secondCirlce_Stage1_StrokeEnd),
                                                          @(secondCirlce_Stage2_StrokeEnd),
                                                          @(secondCirlce_Stage3_StrokeEnd),
                                                          @(secondCirlce_Stage4_StrokeEnd)];
    return secondCirlce_StrokeEnd_Values;
}

- (NSArray<NSNumber*>*)create_Fast_Second_Cirlce_StrokeStart_Values {
    
    
    double secondCirlce_Stage0_StrokeStart = 0;
    double secondCirlce_Stage1_StrokeStart = second_Circle_Stage1_StrokeStart;
    double secondCirlce_Stage2_StrokeStart = second_Circle_Stage2_StrokeStart;
    double secondCirlce_Stage3_StrokeStart = second_Circle_Stage3_StrokeStart;
    double secondCirlce_Stage4_StrokeStart = second_Circle_Stage4_StrokeStart;
    
    NSArray<NSNumber*> *secondCirlce_StrokeStart_Values = @[@(secondCirlce_Stage0_StrokeStart),
                                                            @(secondCirlce_Stage1_StrokeStart),
                                                            @(secondCirlce_Stage2_StrokeStart),
                                                            @(secondCirlce_Stage3_StrokeStart),
                                                            @(secondCirlce_Stage4_StrokeStart)];
    return secondCirlce_StrokeStart_Values;
}

- (NSArray<NSNumber*>*)create_Slow_Second_Cirlce_StrokeEnd_Values {
    
    
    double secondCirlce_Stage0_StrokeEnd = 0;
    double secondCirlce_Stage1_StrokeEnd = 0;
    double secondCirlce_Stage2_StrokeEnd = second_Circle_Stage1_StrokeEnd;
    double secondCirlce_Stage3_StrokeEnd = second_Circle_Stage2_StrokeEnd;
    double secondCirlce_Stage4_StrokeEnd = second_Circle_Stage3_StrokeEnd;
    double secondCirlce_Stage5_StrokeEnd = second_Circle_Stage4_StrokeEnd;
    
    NSArray<NSNumber*>* secondCirlce_StrokeEnd_Values = @[@(secondCirlce_Stage0_StrokeEnd),
                                                          @(secondCirlce_Stage1_StrokeEnd),
                                                          @(secondCirlce_Stage2_StrokeEnd),
                                                          @(secondCirlce_Stage3_StrokeEnd),
                                                          @(secondCirlce_Stage4_StrokeEnd),
                                                          @(secondCirlce_Stage5_StrokeEnd)];
    return secondCirlce_StrokeEnd_Values;
}

- (NSArray<NSNumber*>*)create_Slow_Second_Cirlce_StrokeStart_Values {
    
    
    double secondCirlce_Stage0_StrokeStart = 0;
    double secondCirlce_Stage1_StrokeStart = 0;
    double secondCirlce_Stage2_StrokeStart = second_Circle_Stage1_StrokeStart;
    double secondCirlce_Stage3_StrokeStart = second_Circle_Stage2_StrokeStart;
    double secondCirlce_Stage4_StrokeStart = second_Circle_Stage3_StrokeStart;
    double secondCirlce_Stage5_StrokeStart = second_Circle_Stage4_StrokeStart;
    
    NSArray<NSNumber*> *secondCirlce_StrokeStart_Values = @[@(secondCirlce_Stage0_StrokeStart),
                                                            @(secondCirlce_Stage1_StrokeStart),
                                                            @(secondCirlce_Stage2_StrokeStart),
                                                            @(secondCirlce_Stage3_StrokeStart),
                                                            @(secondCirlce_Stage4_StrokeStart),
                                                            @(secondCirlce_Stage5_StrokeStart)];
    return secondCirlce_StrokeStart_Values;
}


#pragma mark 第三个圈圈（快和慢）
- (NSArray<NSNumber*>*)create_Third_Cirlce_StrokeEnd_Values {
    
    
    double thirdCirlce_Stage0_StrokeEnd = 0;
    double thirdCirlce_Stage1_StrokeEnd = 0;
    double thirdCirlce_Stage2_StrokeEnd = 0;
    double thirdCirlce_Stage3_StrokeEnd = 0;
    double thirdCirlce_Stage4_StrokeEnd = third_Circle_Stage3_StrokeEnd;
    double thirdCirlce_Stage5_StrokeEnd = third_Circle_Stage4_StrokeEnd;
    
    NSArray<NSNumber*>* thirdCirlce_StrokeEnd_Values = @[@(thirdCirlce_Stage0_StrokeEnd),
                                                         @(thirdCirlce_Stage1_StrokeEnd),
                                                         @(thirdCirlce_Stage2_StrokeEnd),
                                                         @(thirdCirlce_Stage3_StrokeEnd),
                                                         @(thirdCirlce_Stage4_StrokeEnd),
                                                         @(thirdCirlce_Stage5_StrokeEnd)];
    return thirdCirlce_StrokeEnd_Values;
}
- (NSArray<NSNumber*>*)create_Third_Cirlce_StrokeStart_Values {
    
    
    double thirdCirlce_Stage0_StrokeStart = 0;
    double thirdCirlce_Stage1_StrokeStart = 0;
    double thirdCirlce_Stage2_StrokeStart = 0;
    double thirdCirlce_Stage3_StrokeStart = 0;
    double thirdCirlce_Stage4_StrokeStart = third_Circle_Stage3_StrokeStart;
    double thirdCirlce_Stage5_StrokeStart = third_Circle_Stage4_StrokeStart;
    
    NSArray<NSNumber*>* thirdCirlce_StrokeEnd_Values = @[@(thirdCirlce_Stage0_StrokeStart),
                                                         @(thirdCirlce_Stage1_StrokeStart),
                                                         @(thirdCirlce_Stage2_StrokeStart),
                                                         @(thirdCirlce_Stage3_StrokeStart),
                                                         @(thirdCirlce_Stage4_StrokeStart),
                                                         @(thirdCirlce_Stage5_StrokeStart)];
    return thirdCirlce_StrokeEnd_Values;
}

@end
