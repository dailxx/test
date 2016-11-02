//
//  ABAppContext.h
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABAppContext : NSObject

//凡是未声明成readonly的都是需要在初始化的时候由外面给的

// 设备信息
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *model;
@property (nonatomic, copy, readonly) NSString *os;
@property (nonatomic, copy, readonly) NSString *rom;
@property (nonatomic, copy, readonly) NSString *ppi;
@property (nonatomic, copy, readonly) NSString *imei;
@property (nonatomic, copy, readonly) NSString *imsi;
@property (nonatomic, copy, readonly) NSString *deviceName;
@property (nonatomic, assign, readonly) CGSize resolution;

// 运行环境相关
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isOnline;

// 地理位置
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, assign, readonly) CGFloat longitude;

+ (instancetype)sharedInstance;

@end
