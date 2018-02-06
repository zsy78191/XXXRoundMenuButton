//
//  ViewController.m
//  demo
//
//  Created by 张超 on 16/1/4.
//  Copyright © 2016年 gerinn. All rights reserved.
//

#import "ViewController.h"
#import "XXXRoundMenuButton.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet XXXRoundMenuButton *roundMenu;
@property (weak, nonatomic) IBOutlet XXXRoundMenuButton *roundMenu2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.roundMenu.centerButtonSize = CGSizeMake(44, 44);
    self.roundMenu.centerIconType = XXXIconTypeUserDraw;
    self.roundMenu.tintColor = [UIColor whiteColor];
    self.roundMenu.jumpOutButtonOnebyOne = YES;
    
    [self.roundMenu setDrawCenterButtonIconBlock:^(CGRect rect, UIControlState state) {
        
        if (state == UIControlStateNormal)
        {
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 - 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectanglePath fill];
            
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle2Path fill];
            
            UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 + 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle3Path fill];
        }
    }];
    
    [self.roundMenu loadButtonWithIcons:@[
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"],
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"],
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"]
                                          
                                          ] startDegree:0 layoutDegree:M_PI*2*7/8
                    WithIconDescription:@[
                                          @"日历",
                                          @"位置",
                                          @"相册",
                                          @"日期",
                                          @"地理",
                                          @"照片",
                                          @"农历",
                                          @"方位",
                                          @"写真"]];
    
    [self.roundMenu setButtonClickBlock:^(NSInteger idx) {
        
        NSLog(@"button %@ clicked !",@(idx));
    }];
    
    
    
    
    
    /**
     *  RoundMenu2 config
     */
    [self.roundMenu2 loadButtonWithIcons:@[
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"],
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"]
                                          
                                          ] startDegree:-M_PI layoutDegree:M_PI
                     WithIconDescription:@[
                                           @"日历",
                                           @"位置",
                                           @"图片",
                                           @"日期",
                                           @"GPS",
                                           @"写真"
                                           ]];
    [self.roundMenu2 setButtonClickBlock:^(NSInteger idx) {
        
        NSLog(@"button %@ clicked !",@(idx));
    }];
    
    [self.roundMenu2 setCenterIcon:[UIImage imageNamed:@"icon_pos"]];
    [self.roundMenu2 setCenterIconType:XXXIconTypeCustomImage];
    
    self.roundMenu2.tintColor = [UIColor whiteColor];
    
    self.roundMenu2.mainColor = [UIColor colorWithRed:0.13 green:0.58 blue:0.95 alpha:1];
    
    self.roundMenu2.offsetAfterOpened = CGSizeMake(-80, -80);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
