//
//  DESUtils.h
//  TT
//
//  Created by 张志恒 on 16/3/7.
//  Copyright © 2016年 张志恒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABDESUtil : NSObject
/**
 *  DES加密
 *
 *  @param plainText 加密的文本
 *  @param key       密匙
 *  @param iv        初始向量
 *
 *  @return 加密结果
 */
+ (NSString *)encrypt:(NSString *)plainText withKey:(NSString *)key andIV:(NSString *)iv;
/**
 *  DES解密
 *
 *  @param encryptText 解密的文本
 *  @param key         密匙
 *  @param iv          初始向量
 *
 *  @return 解密结果
 */
+ (NSString *)decrypt:(NSString*)encryptText withKey:(NSString *)key andIV:(NSString *)iv;

@end
