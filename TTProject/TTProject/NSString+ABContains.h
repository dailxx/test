//
//  NSString+ABContains.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABContains)
/**
 *  @brief 是否包含指定字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)ab_containsString:(NSString *)string;
/**
 *  @brief 是否包含指定字符集
 *
 *  @param set 字符集
 *
 *  @return YES, 包含;
 */
- (BOOL)ab_containsCharacterSet:(NSCharacterSet *)set;
/**
 *  @brief  判断字符串中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)ab_isContainChinese;

@end
