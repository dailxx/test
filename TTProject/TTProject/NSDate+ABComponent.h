//
//  NSDate+ABComponent.h
//  TTProject
//
//  Created by 张志恒 on 16/8/30.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+ABModify.h"

@interface NSDate (ABComponent)
@property (nonatomic, readonly) NSInteger ab_year; ///< Year component
@property (nonatomic, readonly) NSInteger ab_month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger ab_day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger ab_hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger ab_minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger ab_second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger ab_nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger ab_weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger ab_weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger ab_weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger ab_weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger ab_yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger ab_quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL ab_isLeapMonth; ///< whether the month is leap month
@property (nonatomic, readonly) BOOL ab_isLeapYear; ///< whether the year is leap year
@property (nonatomic, readonly) BOOL ab_isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL ab_isYesterday; ///< whether date is yesterday (based on current locale)
@end
