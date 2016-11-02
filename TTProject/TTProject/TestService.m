//
//  TestService.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "TestService.h"

NSString * const kABServiceTest = @"kABServiceTest";

@implementation TestService

#pragma mark - ABServiceProtocal
- (BOOL)isOnline
{
    return NO;
}

- (NSString *)onlineApiBaseUrl
{
    return @"https://appt01.corpautohome.com";
}

- (NSString *)offlineApiBaseUrl
{
    return @"http://10.168.66.153";
}

- (NSString *)onlinePublicKey
{
    return @"";
}

- (NSString *)offlinePublicKey
{
    return @"";
}

- (NSString *)onlinePrivateKey
{
    return @"";
}

- (NSString *)offlinePrivateKey
{
    return @"";
}

- (NSString *)onlineApiVersion
{
    return @"";
}

- (NSString *)offlineApiVersion
{
    return @"";
}

@end
