//
//  XXXRoundMenuButton.h
//  ilist
//
//  Created by 张超 on 16/1/2.
//  Copyright © 2016年 gerinn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, XXXIconType) {
    XXXIconTypePlus = 0,
    XXXIconTypeUserDraw
};

@interface XXXRoundMenuButton : UIControl

@property (nonatomic, assign) CGSize centerButtonSize;
@property (nonatomic, assign) XXXIconType centerIconType;
@property (nonatomic, assign) BOOL jumpOutButtonOnebyOne;
@property (nonatomic, strong) UIColor* mainColor;

- (void)loadButtonWithIcons:(NSArray<UIImage*>*)icons startDegree:(CGFloat)degree layoutDegree:(CGFloat)layoutDegree;

@property (nonatomic, strong) void (^buttonClickBlock) (NSInteger idx);
@property (nonatomic, strong) void (^drawCenterButtonIconBlock)(CGRect rect , UIControlState state);



@end
