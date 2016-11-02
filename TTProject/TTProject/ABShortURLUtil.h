//
//  ABShortURLUtil.h
//  TTProject
//
//  Created by 张志恒 on 16/9/6.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+ABHash.h"
/**
 *  短URL算法
 *  将原始长链接进行MD5加密，为了避免防止算法泄漏，可以在原链接上添加自定义的字符串作为密钥；
 *  把128位的MD分成四组，每组32位，对应一个候选短链接；
 *  对于每个32位的数，将它与0x3FFFFFFF进行位与运算，取其低30位的数据。把得到的值与0x0000003D进行位与运算，再把得到的结果作为下标在字符表中选取字符，再把原数字右移5位进行相同操作，重复进行6次得到6个字符，即组成一个候选短链接地址；
 *  在4个候选短链接中随机选择一个作为最终的短链接。
 */
@interface ABShortURLUtil : NSObject
/**
 *  获取短链接地址
 *
 *  @param longURL 原始链接
 *
 *  @return 短链接地址
 */
+ (NSString *)shortURL:(NSString *)longURL;
/**
 *  根据密匙获取短链接地址
 *
 *  @param longURL 原始链接
 *  @param key     密匙
 *
 *  @return 短链接地址
 */
+ (NSString *)shortURL:(NSString *)longURL wikeKey:(NSString *)key;

@end
