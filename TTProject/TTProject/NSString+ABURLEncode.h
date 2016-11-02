//
//  NSString+ABURLEncode.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABURLEncode)
/**
 *  @brief  urlEncode
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)ab_urlEncode;
/**
 *  @brief  urlDecode
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)ab_urlDecode;

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)ab_dictionaryFromURLParameters;

@end
