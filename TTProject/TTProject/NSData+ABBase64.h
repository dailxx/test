//
//  NSData+ABBase64.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ABBase64)
/**
 Returns an NSString for base64 encoded.
 */
- (NSString *)ab_base64EncodedString;

/**
 Returns an NSData from base64 encoded string.
 
 @warning This method has been implemented in iOS7.
 
 @param base64EncodedString  The encoded string.
 */
+ (NSData *)ab_dataWithBase64EncodedString:(NSString *)base64EncodedString;

@end
