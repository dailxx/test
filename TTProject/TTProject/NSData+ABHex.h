//
//  NSData+ABHex.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ABHex)

/**
 Returns a uppercase NSString in HEX.
 */
- (NSString *)ab_hexString;

/**
 Returns an NSData from hex string.
 
 @param hexString   The hex string which is case insensitive.
 
 @return a new NSData, or nil if an error occurs.
 */
+ (NSData *)ab_dataWithHexString:(NSString *)hexStr;

@end
