//
//  UserContext.h
//  TTProject
//
//  Created by 张志恒 on 16/8/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSFileManager+ABPath.h"
/**
 *  登录用户的信息，严禁添加为了编程方便而与用户信息无关的属性
 */
@interface ABUserContext : NSObject<NSCoding>

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *empId;
@property (nonatomic, copy) NSString *empName;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *userKey;

// 存档
- (BOOL)archiveData;
// 重置归档数据
- (BOOL)resetArchiveData;
// 获取归档数据路径
+ (NSString *)filePath;

@end
