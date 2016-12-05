//
//  JMDotView.m
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//



#import "JMDotView.h"
@interface JMDotView() {
    CGSize dotOutRectSize;
}
@end
@implementation JMDotView

- (instancetype)init {
    if (self = [super init]) {
        self.factor = 0;
        self.masksToBounds = false;
        self.contentsScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    // if (dotOutRectSize.width == 0) {
    dotOutRectSize = frame.size;
    [self setNeedsDisplay];
    // }
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"factor"]) {
        return true ;
    }
    return [super needsDisplayForKey:key];
}

- (void) drawInContext:(CGContextRef)ctx {
    
    // width + 1/6*width * 2 = S
    CGFloat percent = (1+1.0/6*2);
    CGSize dotSize = CGSizeMake(self.frame.size.width/percent, self.frame.size.height/percent);
    
    //NSLog(@"%f",_factor);
    
    CGFloat offset =  dotSize.width / 3.6;
    
    CGFloat moveDistance = dotSize.width * 1/6 * _factor;
    
    CGPoint center =  CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    CGPoint pointA = CGPointMake(center.x,center.y-dotSize.height/2+moveDistance);
    
    CGPoint pointB = CGPointMake(center.x+dotSize.width/2+moveDistance, center.y);
    
    CGPoint pointC = CGPointMake(center.x, center.y+dotSize.height/2-moveDistance);
    
    CGPoint pointD = CGPointMake(center.x-dotSize.width/2-moveDistance, center.y);
    
    CGPoint c1 = CGPointMake(pointA.x+offset,pointA.y);
    
    CGPoint c2 = CGPointMake(pointB.x, pointB.y-offset);
    
    CGPoint c3 = CGPointMake(pointB.x, pointB.y+offset);
    
    CGPoint c4 = CGPointMake(pointC.x+offset,pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x-offset, pointC.y);
    
    CGPoint c6 = CGPointMake(pointD.x, pointD.y+offset);
    
    CGPoint c7 = CGPointMake(pointD.x, pointD.y-offset);
    
    CGPoint c8 = CGPointMake(pointA.x-offset, pointA.y);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [path addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [path addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [path addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [path closePath];
    
    CGContextAddPath(ctx, path.CGPath);
    CGContextSetFillColorWithColor(ctx,[UIColor whiteColor].CGColor);
    CGContextFillPath(ctx);
    
    
}

@end