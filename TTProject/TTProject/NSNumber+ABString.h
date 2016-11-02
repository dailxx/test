//
//  NSNumber+ABString.h
//  TTProject
//
//  Created by 张志恒 on 16/8/30.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 Provide a method to parse `NSString` for `NSNumber`.
 */
@interface NSNumber (ABString)
/**
 Creates and returns an NSNumber object from a string.
 Valid format: @"12", @"12.345", @" -0xFF", @" .23e99 "...
 
 @param string  The string described an number.
 
 @return an NSNumber when parse succeed, or nil if an error occurs.
 */
+ (NSNumber *)ab_numberWithString:(NSString *)string;

@end
