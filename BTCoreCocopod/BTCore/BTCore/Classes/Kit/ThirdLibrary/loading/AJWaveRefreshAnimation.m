//
//  AJWaveRefreshAnimation.m
//  AJWaveRefresh
//
//  Created by AlienJunX on 15/10/16.
//  Copyright (c) 2015 AlienJunX
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "AJWaveRefreshAnimation.h"
#import "UIColor+ZMHex.h"
#import "prefixHeader.h"

@interface AJWaveRefreshAnimation()
@property (nonatomic) CGFloat waveWidth;
@property (nonatomic) CGFloat waveHeight;
@property (nonatomic) CGFloat density;
@property (nonatomic) CGFloat waveMid;
@property (nonatomic) CGFloat maxAmplitude;

@property (nonatomic) CGFloat phaseShift;
@property (nonatomic) CGFloat phase;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (strong, nonatomic) CAShapeLayer *waveLayer;

@property (weak, nonatomic) UIImageView *grayLogo;
@property (weak, nonatomic) UIImageView *redLogo;
@property (weak, nonatomic) UILabel * lbNoti;//加载中


@end

@implementation AJWaveRefreshAnimation

- (instancetype)initWithFrame:(CGRect)frame
                    grayImage:(UIImage *)grayImage
                     redImage:(UIImage *)redImage {
    _redLogoImage = redImage;
    _grayLogoImage = grayImage;
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    
    //图片 写死50
    UIImageView *grayLogo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
    UIImageView *redLogo = [[UIImageView alloc] initWithFrame:grayLogo.frame];
    grayLogo.zm_centerX = self.bounds.size.width/2.0;
    redLogo.zm_centerX = grayLogo.zm_centerX;
    self.waveLayer.frame= grayLogo.frame;
    grayLogo.image = self.grayLogoImage;
    redLogo.image = self.redLogoImage;
    
    
    [self addSubview:grayLogo];
    [self addSubview:redLogo];
    UILabel * lb = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 70 , self.bounds.size.width,30)];
    _lbNoti = lb;
    [self addSubview:lb];
    self.notiString = @"加载中";
    lb.text = _notiString;
    lb.textColor = [UIColor zm_colorWithHexString:@"#00a0ea"];
    lb.font = [UIFont systemFontOfSize:14];
    lb.textAlignment = NSTextAlignmentCenter;
    
    self.grayLogo = grayLogo;
    self.redLogo = redLogo;
    
    
    CALayer *mask = [CALayer layer];
    mask.frame = grayLogo.bounds;
    self.waveLayer = [CAShapeLayer layer];
    self.waveLayer.fillColor = [[UIColor greenColor] CGColor];
    self.waveLayer.frame = CGRectMake(0, self.grayLogo.bounds.size.height-5, self.grayLogo.bounds.size.width, self.grayLogo.bounds.size.height);
    
    self.waveHeight = CGRectGetHeight(grayLogo.bounds)*0.12;
    self.waveWidth  = CGRectGetWidth(grayLogo.bounds);
    self.density = 1.f;
    self.frequency = 1.5f;
    self.phaseShift = -0.25f;
    self.notiString = @"加载中";
    
    
    //mask
    [mask addSublayer:self.waveLayer];
    self.redLogo.layer.mask = mask;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    effectView.backgroundColor = [UIColor whiteColor];
//    effectView.alpha = 0.7;
    effectView.contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];

    effectView.frame = self.bounds;
    
    [self insertSubview:effectView atIndex:0];
    self.layer.cornerRadius = 12;
    self.layer.masksToBounds = YES;
}

- (void)startAnimating {
    _times = 0;
    [self.displayLink invalidate];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    CGPoint position = self.waveLayer.position;
    position.y = position.y - 60-5;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.waveLayer.position.x, self.waveLayer.position.y-20)];
    animation.toValue = [NSValue valueWithCGPoint:position];
    animation.duration = 2.0;
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    [self.waveLayer addAnimation:animation forKey:nil];
}

- (void)stopAnimating {
    [self.displayLink invalidate];
    _times = 0;
    [self.waveLayer removeAllAnimations];
    self.waveLayer.path = nil;
}

//波浪绘制
- (void)update {
    self.phase += self.phaseShift;
    self.waveMid = self.waveWidth / 2.0f;
    self.maxAmplitude = self.waveHeight - 4.0f;
    _times++;
    UIGraphicsBeginImageContext(CGSizeMake(60, 60));
    UIBezierPath *wavePath = [UIBezierPath bezierPath];
    CGFloat endX = 0;
    for (CGFloat x = 0; x<self.waveWidth + self.density; x += self.density) {
        endX=x;
        CGFloat scaling = -pow(x / self.waveMid  - 1, 2) + 1;//波浪中间变大
        CGFloat y = scaling * self.maxAmplitude  * sinf(2 * M_PI *(x / 50) * self.frequency + self.phase) + (self.waveHeight * 0.5);
        if (x==0) {
            [wavePath moveToPoint:CGPointMake(x, y)];
        } else {
            [wavePath addLineToPoint:CGPointMake(x, y)];
        }
    }
//    CGFloat endY = CGRectGetHeight(self.bounds)+15;
    CGFloat endY = 60+15;
    [wavePath addLineToPoint:CGPointMake(endX, endY)];
    [wavePath addLineToPoint:CGPointMake(0, endY)];
    [wavePath addLineToPoint:CGPointMake(0, 5)];
    
    self.waveLayer.path = [wavePath CGPath];
    UIGraphicsEndImageContext();
}


#pragma mark - getter/setter
- (void)setGrayLogoImage:(UIImage *)grayLogoImage {
    _grayLogoImage = grayLogoImage;
    self.grayLogo.image = grayLogoImage;
}

- (void)setRedLogoImage:(UIImage *)redLogoImage {
    _redLogoImage = redLogoImage;
    self.redLogo.image = redLogoImage;
}

- (void)setNotiString:(NSString *)notiString
{
    _notiString = notiString;
    _lbNoti.text = notiString;
    
}

@end
