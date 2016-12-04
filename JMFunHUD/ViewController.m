//
//  ViewController.m
//  JMFunHUD
//
//  Created by 萧锐杰 on 16/12/4.
//  Copyright © 2016年 Jeremy. All rights reserved.
//

#import "ViewController.h"
#import "JMFunHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showDimHUD:(UIButton *)sender {
    
    JMFunHUD *hud = [JMFunHUD hudForView:self.view];
    hud.backgroundType = JMFunHUDBackgroundTypeDim;
    [hud show:YES];
    [self performHideAfterSecond:10 hud:hud];
}
- (IBAction)showDefaultHUD:(UIButton *)sender {
    
    JMFunHUD *hud = [JMFunHUD hudForView:self.view];
    hud.backgroundType = JMFunHUDBackgroundTypeNone;
    [hud show:YES];
    [self performHideAfterSecond:10 hud:hud];
}
- (IBAction)showBlurHUD:(UIButton *)sender {
    
    JMFunHUD *hud = [JMFunHUD hudForView:self.view];
    hud.backgroundType = JMFunHUDBackgroundTypeBlur;
    [hud show:YES];
    [self performHideAfterSecond:10 hud:hud];
}
- (IBAction)showSharedHUD:(UIButton *)sender {
    
    //
    [JMFunHUD showSharedHUD:YES withType:JMFunHUDBackgroundTypeBlur];
    
    [self performHideAfterSecond:10 hud:[JMFunHUD sharedHUD]];
    
    //or you can show sharedHUD as shown below
    /*
    JMFunHUD *hud = [JMFunHUD sharedHUD];
    hud.backgroundType = JMFunHUDBackgroundTypeBlur;
    [hud show:YES];
     */
}

- (void)performHideAfterSecond:(double)sec hud:(JMFunHUD *)hud {
    uint64_t msc = sec * 1000;
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * msc);
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [hud hide:true];
        //if hud is a sharedHUD,hide it using that shown below
        //[JMFunHUD hideSharedHUD:YES];
    });
}

@end






