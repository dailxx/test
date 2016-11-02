//
//  UIImage+ABAlpha.h
//  TTProject
//
//  Created by 张志恒 on 16/8/31.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ABAlpha)
/**
 *  @brief  返回该图片是否有透明度通道
 *
 *  @return 是否有透明度通道
 */
- (BOOL)ab_hasAlphaChannel;

@end
