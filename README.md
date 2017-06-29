# New at 2017.5.11
Add offset after the menu is opened.
```objc
self.roundMenu2.offsetAfterOpened = CGSizeMake(-80, -80);
```
![preview](https://raw.githubusercontent.com/zsy78191/XXXRoundMenuButton/master/Untitled.gif)

# New at 6.16
1. Add function to set custom image as center button icon.
2. Add swift demo.

## CocoaPods



# XXXRoundMenuButton
一个简单的圆形菜单控件。设计来自InVision团队的 [Filter Menu by Anton Aheichanka for InVision](https://dribbble.com/shots/1956586-Filter-Menu) 和  [Secret Project by Anton Aheichanka Follow for InVision Follow](https://dribbble.com/shots/1928064-Secret-Project)

A simple circle style menu. Design from [Filter Menu by Anton Aheichanka for InVision](https://dribbble.com/shots/1956586-Filter-Menu)
and [Secret Project by Anton Aheichanka Follow for InVision Follow](https://dribbble.com/shots/1928064-Secret-Project)

![preview](https://raw.githubusercontent.com/zsy78191/XXXRoundMenuButton/master/XXXRoundMenu.gif)

## Angle
 
```objc
/**
*  config function
*
*  @param icons        array of UIImages
*  @param degree       start degree
*  @param layoutDegree angle span
*/
- (void)loadButtonWithIcons:(NSArray<UIImage*>*)icons startDegree:(CGFloat)degree layoutDegree:(CGFloat)layoutDegree;

```

startDegree 0 degree is ⬇️ ， layoutDegree is the span between start and end, **counterclockwise**.

## Update

2016.4.19 Fix the issue that touch event can't send to UIView covered by XXXRoundMenuButton

## Easy use interface

```objc
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

] startDegree:0 layoutDegree:M_PI*2*7/8];

[self.roundMenu setButtonClickBlock:^(NSInteger idx) {

NSLog(@"button %@ clicked !",@(idx));
}];


/**
*  RoundMenu2 config
*/
[self.roundMenu2 loadButtonWithIcons:@[
[UIImage imageNamed:@"icon_can"],
[UIImage imageNamed:@"icon_pos"],
[UIImage imageNamed:@"icon_img"]

] startDegree:-M_PI layoutDegree:M_PI/2];
[self.roundMenu2 setButtonClickBlock:^(NSInteger idx) {

NSLog(@"button %@ clicked !",@(idx));
}];

self.roundMenu2.tintColor = [UIColor whiteColor];

self.roundMenu2.mainColor = [UIColor colorWithRed:0.13 green:0.58 blue:0.95 alpha:1];
```


