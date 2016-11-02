//
//  ABProgressHUD.m
//  TTProject
//
//  Created by 张志恒 on 16/8/25.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABProgressHUD.h"

@interface ABProgressHUD ()

@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIImageView *ringView;
@property (nonatomic, strong) UIImageView *backgroundRingView;

@end

@implementation ABProgressHUD

#pragma mark - instance methods

+ (ABProgressHUD *)sharedView
{
    static ABProgressHUD *sharedView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedView = [[self alloc] initWithFrame:[[[UIApplication sharedApplication] delegate] window].bounds];
    });
    return sharedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.alpha = 0.f;
    }
    return self;
}

#pragma mark - Show & hide

+ (void)show
{
    __weak ABProgressHUD *weakSelf = [self sharedView];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong ABProgressHUD *strongSelf = weakSelf;
        if (strongSelf) {
            // Update / Check view hierachy to ensure the HUD is visible
            [strongSelf updateViewHierachy];
            
            // Add indefiniteAnimatedView to HUD
            [strongSelf.hudView addSubview:strongSelf.ringView];
            [strongSelf.hudView addSubview:strongSelf.backgroundRingView];
            [strongSelf startAnimating];
            
            // Update ring view frame and position
            [strongSelf updateHUDFrame];
            
            [strongSelf showStatus:nil];
        }
    }];
}

- (void)showStatus:(NSString *)status
{
    // Show overlay
    self.overlayView.backgroundColor = [UIColor clearColor];
    
    // Show if not already visible (depending on alpha)
    if(self.alpha != 1.0f || self.hudView.alpha != 1.0f) {
        // Set initial values to handle iOS 7 (and above) UIToolbar which not answers well to hierarchy opacity change
        self.alpha = 1.0f;
        self.hudView.alpha = 1.0f;
        
        // Inform iOS to redraw the view hierachy
        [self setNeedsDisplay];
    }
}

+ (void)dimiss
{
    [self dismissWithDelay:0.f completion:nil];
}

+ (void)dimissWithDelay:(NSTimeInterval)delay
{
    [self dismissWithDelay:delay completion:nil];
}

+ (void)dismissWithCompletion:(ABProgressHUDDimissCompletionBlock)completion
{
    [self dismissWithDelay:0.f completion:completion];
}

+ (void)dismissWithDelay:(NSTimeInterval)delay completion:(ABProgressHUDDimissCompletionBlock)completion
{
    [[self sharedView] dismissWithDelay:delay completion:completion];
}

- (void)dismissWithDelay:(NSTimeInterval)delay completion:(ABProgressHUDDimissCompletionBlock)completion
{
    __weak ABProgressHUD *weakSelf = self;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        __strong ABProgressHUD *strongSelf = weakSelf;
        if (strongSelf) {
            // Dismiss if visible (depending on alpha)
            if (strongSelf.alpha != 0.f || strongSelf.hudView.alpha != 0.f) {

                [strongSelf performSelector:@selector(stopAnimating:)
                                 withObject:completion
                                 afterDelay:delay
                                    inModes:@[NSRunLoopCommonModes]];
            }
            
            // Inform iOS to redraw the view hierachy
            [strongSelf setNeedsDisplay];
        } else if (completion) {
            completion();
        }
    }];
}

#pragma mark - animations
- (void)startAnimating
{
    // Clear previous all animations
    [self.ringView.layer removeAllAnimations];
    
    // Add rotate animation to ring view
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.toValue = @(4 * M_PI);
    rotateAnimation.duration = 2.f;
    rotateAnimation.repeatCount = NSIntegerMax;
    [self.ringView.layer addAnimation:rotateAnimation forKey:@"rotate"];
}

- (void)stopAnimating:(ABProgressHUDDimissCompletionBlock)completion
{
    // Call block
    if (completion) {
        completion();
    }
    
    // Clear previous all animations
    [self.ringView.layer removeAllAnimations];
    
    // Clean up view hierachy (overlays)
    [self.ringView removeFromSuperview];
    [self.backgroundRingView removeFromSuperview];
    [self.overlayView removeFromSuperview];
    [self.hudView removeFromSuperview];
    [self removeFromSuperview];
    
    
}

#pragma mark - helper methods
- (void)updateViewHierachy
{
    // Add the overlay (e.g. black, gradient) to the application window if necessary
    if (!self.overlayView.superview) {
        // Default case: iterate over UIApplication windows
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows) {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.overlayView];
                break;
            }
        }
    } else {
        // The HUD is already on screen, but maybot not in front. Therefore
        // ensure that overlay will be on top of rootViewController (which may
        // be changed during runtime).
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    
    // Add self to the overlay view
    if(!self.superview){
        [self.overlayView addSubview:self];
    }
    if(!self.hudView.superview) {
        [self addSubview:self.hudView];
    }
}

- (void)updateHUDFrame
{
    self.ringView.frame = CGRectMake(0, 0, 78.f, 78.f);
    self.backgroundRingView.frame = CGRectMake(0, 0, 80.f, 80.f);
    
    CGPoint center = CGPointMake(self.hudView.frame.size.width / 2.f,
                                 self.hudView.frame.size.height / 2.f);
    self.ringView.center = center;
    self.backgroundRingView.center = center;
}

#pragma mark - getters
- (UIControl *)overlayView
{
    if (!_overlayView) {
        CGRect windowBounds = [[[UIApplication sharedApplication] delegate] window].bounds;
        _overlayView = [[UIControl alloc] initWithFrame:windowBounds];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.backgroundColor = [UIColor clearColor];
    }
    return _overlayView;
}

- (UIView *)hudView
{
    if (!_hudView) {
        _hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        _hudView.layer.masksToBounds = YES;
        _hudView.layer.cornerRadius = 9.f;
        _hudView.backgroundColor = [UIColor ab_colorWithWholeRed:238.f
                                                           green:238.f
                                                            blue:238.f];
        _hudView.center = self.center;
    }
    return _hudView;
}

- (UIImageView *)ringView
{
    if (!_ringView) {
        _ringView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _ringView.image = [UIImage imageNamed:@"loading_circle"];
    }
    return _ringView;
}

- (UIImageView *)backgroundRingView
{
    if (!_backgroundRingView) {
        _backgroundRingView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _backgroundRingView.image = [UIImage imageNamed:@"loading_logo"];
    }
    return _backgroundRingView;
}

@end
