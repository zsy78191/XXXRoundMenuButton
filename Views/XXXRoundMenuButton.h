//
//  XXXRoundMenuButton.h
//  ilist
//
//  Created by 张超 on 16/1/2.
//  Copyright © 2016年 gerinn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, XXXIconType) {
    
    XXXIconTypePlus = 0, // plus icon
    XXXIconTypeUserDraw  // draw icon by youself
};

@interface XXXRoundMenuButton : UIControl

/**
 *  center button size ; default is CGSize(50,50)
 */
@property (nonatomic, assign) CGSize centerButtonSize;

/**
 *  "XXXIconTypePlus" is a "plus" icon. "XXXIconTypeUserDraw" must use "drawCenterButtonIconBlock" draw with CoreGraphic.
 */
@property (nonatomic, assign) XXXIconType centerIconType;

/**
 *  animate style, if you want icon jump out one by one , set it YES, default is NO;
 */
@property (nonatomic, assign) BOOL jumpOutButtonOnebyOne;

/**
 *  main color
 */
@property (nonatomic, strong) UIColor* mainColor;

/**
 *  config function
 *
 *  @param icons        array of UIImages
 *  @param degree       start degree
 *  @param layoutDegree angle span
 */
- (void)loadButtonWithIcons:(NSArray<UIImage*>*)icons startDegree:(CGFloat)degree layoutDegree:(CGFloat)layoutDegree;

/**
 *  click block
 */
@property (nonatomic, strong) void (^buttonClickBlock) (NSInteger idx);

/**
 *  draw center icon block
 */
@property (nonatomic, strong) void (^drawCenterButtonIconBlock)(CGRect rect , UIControlState state);



@end
