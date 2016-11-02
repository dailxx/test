//
//  UIImage+ABOrientation.h
//  TTProject
//
//  Created by 张志恒 on 16/8/31.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABOrientation)
/**
 *  @brief  修正图片的方向
 *
 *  @param srcImg 图片
 *
 *  @return 修正方向后的图片
 */
+ (UIImage *)ab_fixOrientation:(UIImage *)srcImg;

@end
