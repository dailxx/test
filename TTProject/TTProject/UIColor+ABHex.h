//
//  UIColor+ABHex.h
//  TTProject
//
//  Created by 张志恒 on 16/8/24.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  十六进制颜色
 */
@interface UIColor (ABHex)

+ (UIColor *)ab_colorWithHex:(UInt32)hex;
+ (UIColor *)ab_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)ab_colorWithHexString:(NSString *)hexString;

- (NSString *)ab_HEXString;

+ (UIColor *)ab_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue
                            alpha:(CGFloat)alpha;

+ (UIColor *)ab_colorWithWholeRed:(CGFloat)red
                            green:(CGFloat)green
                             blue:(CGFloat)blue;

@end
