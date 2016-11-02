//
//  UIImage+ABColor.h
//  TTProject
//
//  Created by 张志恒 on 16/8/31.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABColor)

/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *  @param size 图片大小
 *
 *  @return 纯色图片
 */
+ (UIImage *)ab_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (UIColor *)ab_colorAtPoint:(CGPoint )point;

@end
