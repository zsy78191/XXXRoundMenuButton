//
//  XXXRoundMenuButton.m
//  ilist
//
//  Created by 张超 on 16/1/2.
//  Copyright © 2016年 gerinn. All rights reserved.
//

#import "XXXRoundMenuButton.h"

@interface XXX_centerButton : UIButton

@property (nonatomic, strong) UIColor* normalColor;
@property (nonatomic, strong) UIColor* selectedColor;

@property (nonatomic, assign) XXXIconType type;
- (instancetype)initWithFrame:(CGRect)frame type:(XXXIconType)type;

@end

@interface XXX_roundCircle : UIView
@property (nonatomic, strong) UIColor* circleColor;
- (void)clean;
- (void)animatedLoadIcons:(NSArray<UIImage*>*)icons start:(CGFloat)start layoutDegree:(CGFloat)layoutDegree oneByOne:(BOOL)onebyone;
@end

@interface XXXRoundMenuButton ()
{
    
}
@property (nonatomic, strong) XXX_centerButton * centerButton;
@property (nonatomic, strong) XXX_roundCircle * roundCircle;

- (void)drawCentenIconInRect:(CGRect)rect state:(UIControlState)state;

@property (nonatomic, assign) CGFloat startDegree;
@property (nonatomic, assign) CGFloat layoutDegree;
@property (nonatomic, strong) NSMutableArray* icons;


@end

@implementation XXXRoundMenuButton

- (UIColor*)add_darkerColorWithValue:(CGFloat)value origin:(UIColor*)origin
{
    size_t totalComponents = CGColorGetNumberOfComponents(origin.CGColor);
    BOOL isGreyscale = (totalComponents == 2) ? YES : NO;
    
    CGFloat const * oldComponents = (CGFloat *)CGColorGetComponents(origin.CGColor);
    CGFloat newComponents[4];
    
    CGFloat (^actionBlock)(CGFloat component) = ^CGFloat(CGFloat component) {
        
        CGFloat newComponent = component * (1.0 - value);
        
        // CGFloat newComponent = component - value < 0.0 ? 0.0 : component - value;
        
        return newComponent;
    };
    
    if (isGreyscale)
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[0]);
        newComponents[2] = actionBlock(oldComponents[0]);
        newComponents[3] = oldComponents[1];
    }
    else
    {
        newComponents[0] = actionBlock(oldComponents[0]);
        newComponents[1] = actionBlock(oldComponents[1]);
        newComponents[2] = actionBlock(oldComponents[2]);
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
    CGColorSpaceRelease(colorSpace);
    
    UIColor *retColor = [UIColor colorWithCGColor:newColor];
    CGColorRelease(newColor);
    
    return retColor;
}


- (NSMutableArray *)icons
{
    if (!_icons) {
        _icons = [NSMutableArray array];
    }
    return _icons;
}

- (void)loadButtonWithIcons:(NSArray<UIImage *> *)icons startDegree:(CGFloat)degree layoutDegree:(CGFloat)layoutDegree
{
    [self.icons removeAllObjects];
    [self.icons addObjectsFromArray:icons];
    
    self.startDegree = degree;
    self.layoutDegree = layoutDegree;
}

- (void)drawCentenIconInRect:(CGRect)rect state:(UIControlState)state
{
    if (self.drawCenterButtonIconBlock) {
        self.drawCenterButtonIconBlock(rect,state);
    }
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    [self setup];
}
     
     
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.mainColor = [UIColor colorWithRed: 0.95 green: 0.2 blue: 0.39 alpha: 1];
    
    self.jumpOutButtonOnebyOne = NO;
    self.centerIconType = XXXIconTypePlus;
    self.centerButtonSize = CGSizeMake(50, 50);
    [self addSubview:self.roundCircle];
    [self addSubview:self.centerButton];
}

- (void)setMainColor:(UIColor *)mainColor
{
    _mainColor = mainColor;
    self.centerButton.normalColor = mainColor;
    self.centerButton.selectedColor = [self add_darkerColorWithValue:0.2 origin:mainColor];
    self.roundCircle.circleColor = mainColor;
}

- (XXX_centerButton *)centerButton
{
    if (!_centerButton) {
        _centerButton = [[XXX_centerButton alloc] initWithFrame:CGRectMake(0, 0, self.centerButtonSize.width, self.centerButtonSize.height) type:self.centerIconType];
        [_centerButton addTarget:self action:@selector(centerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerButton;
}


- (XXX_roundCircle *)roundCircle
{
    if (!_roundCircle) {
        _roundCircle = [[XXX_roundCircle alloc] initWithFrame:CGRectZero];
        _roundCircle.tintColor = self.tintColor;
    }
    return _roundCircle;
}

- (void)setTintColor:(UIColor *)tintColor
{
    [super setTintColor:tintColor];
    
    [self.roundCircle setTintColor:tintColor];
}

- (void)centerButtonClicked:(UIButton*)sender
{
    sender.selected = !sender.selected;
}

- (void)setCenterButtonSize:(CGSize)centerButtonSize
{
    _centerButtonSize = centerButtonSize;
    
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.centerButton.bounds = CGRectMake(0, 0, self.centerButtonSize.width, self.centerButtonSize.height);
    
    self.centerButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    if (self.selected) {
        
        self.roundCircle.frame = self.bounds;
    }
    else
    {
        self.roundCircle.frame = self.centerButton.frame;
    }
    
    [self.roundCircle setNeedsDisplay];
    
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (!selected) {
        [self.roundCircle clean];
    }
    
    [UIView animateWithDuration:0.24
                          delay:0
         usingSpringWithDamping:0.6 initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         if (selected) {
                             
                             self.roundCircle.frame = self.bounds;
                         }
                         else
                         {
                             self.roundCircle.frame = self.centerButton.frame;
                            
                         }
                         
                     } completion:^(BOOL finished) {
                         
                         
                         [self.roundCircle setNeedsDisplay];
                         
                         if (selected) {
                             [self.roundCircle animatedLoadIcons:self.icons start:self.startDegree layoutDegree:self.layoutDegree oneByOne:self.jumpOutButtonOnebyOne];
                         }
                         
                     }];
}

- (void)setCenterIconType:(XXXIconType)centerIconType
{
    _centerIconType = centerIconType;
    
    [self.centerButton setType:centerIconType];
}

- (void)buttonClick:(id)sender
{
    self.centerButton.selected = NO;
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock([sender tag] - 9998);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    

}


@end



@implementation XXX_centerButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(XXXIconType)type
{
    self = [self initWithFrame:frame];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)setType:(XXXIconType)type
{
    _type = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    
    UIColor* color = self.normalColor;
    if (self.highlighted || self.selected) {
        color = self.selectedColor;
    }
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [color setFill];
    [ovalPath fill];
    
    
    if (self.type == XXXIconTypePlus || self.state == UIControlStateSelected) {
        //// Rectangle Drawing
        UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(15, rect.size.height/2 - 0.5, rect.size.width - 30, 1)];
        [UIColor.whiteColor setFill];
        [rectanglePath fill];
        
        
        //// Rectangle 2 Drawing
        UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake(rect.size.width/2 - 0.5, 15, 1, rect.size.height - 30)];
        [UIColor.whiteColor setFill];
        [rectangle2Path fill];
    }
    else if (self.type == XXXIconTypeUserDraw)
    {
        if ([self.superview respondsToSelector:@selector(drawCentenIconInRect:state:)]) {
            [(id)self.superview drawCentenIconInRect:rect state:self.state];
        }
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self setNeedsDisplay];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self setNeedsDisplay];
    
    [UIView animateWithDuration:0.24
                          delay:0
         usingSpringWithDamping:0.6 initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                        self.transform = CGAffineTransformMakeRotation(selected?M_PI_2/2:0);
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
    if ([self.superview respondsToSelector:@selector(setSelected:)]) {
            [(id)self.superview setSelected:selected];
    }
}

@end

@implementation XXX_roundCircle

- (void)clean
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}

- (void)buttonClick:(id)sender
{
    if ([self.superview respondsToSelector:@selector(buttonClick:)]) {
        [(id)self.superview buttonClick:sender];
    }
}

- (void)animatedLoadIcons:(NSArray<UIImage*>*)icons start:(CGFloat)start layoutDegree:(CGFloat)layoutDegree oneByOne:(BOOL)onebyone
{
    [self clean];
    
    CGFloat raduis = self.frame.size.width / 2 - 30;
    
    [icons enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [button setImage:obj forState:UIControlStateNormal];
        button.tintColor = self.tintColor;
        [self addSubview:button];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        button.alpha = 0;
        button.tag = idx + 9998;
        button.transform = CGAffineTransformMakeScale(0.5, 0.5);
        button.center = self.center;
        
        [UIView animateWithDuration:0.2
                              delay:onebyone?idx*0.02:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:5
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             button.alpha = 1;
                             button.transform = CGAffineTransformIdentity;
                             button.center = CGPointMake(self.center.x + raduis * sin(start + layoutDegree/(icons.count-1)*idx), self.center.y + raduis * cos(start + layoutDegree/(icons.count-1)*idx));
                         } completion:^(BOOL finished) {
                             
                         }];
        

    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    //// Color Declarations
    UIColor* color = self.circleColor;
    
    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: rect];
    [color setFill];
    [ovalPath fill];
}

@end
