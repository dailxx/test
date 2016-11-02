//
//  NSDate+ABFormat.h
//  TTProject
//
//  Created by 张志恒 on 16/8/30.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

///=============================================================================
/// @name Date Format
///=============================================================================
@interface NSDate (ABFormat)
/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format   String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @return NSString representing the formatted date string.
 */
- (NSString *)ab_stringWithFormat:(NSString *)format;

/**
 Returns a formatted string representing this date.
 see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns
 for format description.
 
 @param format    String representing the desired date format.
 e.g. @"yyyy-MM-dd HH:mm:ss"
 
 @param timeZone  Desired time zone.
 
 @param locale    Desired locale.
 
 @return NSString representing the formatted date string.
 */
- (NSString *)ab_stringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale;

/**
 Returns a string representing this date in ISO8601 format.
 e.g. "2010-07-09T16:13:30+12:00"
 
 @return NSString representing the formatted date string in ISO8601.
 */
- (NSString *)ab_stringWithISOFormat;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)ab_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 Returns a date parsed from given string interpreted using the format.
 
 @param dateString The string to parse.
 @param format     The string's date format.
 @param timeZone   The time zone, can be nil.
 @param locale     The locale, can be nil.
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)ab_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(NSTimeZone *)timeZone
                             locale:(NSLocale *)locale;

/**
 Returns a date parsed from given string interpreted using the ISO8601 format.
 
 @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
 
 @return A date representation of string interpreted using the format.
 If can not parse the string, returns nil.
 */
+ (NSDate *)ab_dateWithISOFormatString:(NSString *)dateString;

@end
