//
//  ABAppContext.m
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABAppContext.h"
#import "AFNetworking.h"
#import "ABLocationManager.h"

@implementation ABAppContext

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static ABAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

#pragma mark - getters and setters
- (NSString *)type
{
    return @"iOS";
}

- (NSString *)model
{
    return [[UIDevice currentDevice] name];
}

- (NSString *)os
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)rom
{
    return [[UIDevice currentDevice] model];
}

- (NSString *)imei
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)imsi
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)ppi
{
    NSString *ppi = @"";
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,4"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"] ||
             [self.deviceName isEqualToString:@"iPhone8,2"]) {
        ppi = @"401";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,1"]) {
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        ppi = @"132";
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        ppi = @"264";
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        ppi = @"326";
    }
    else {
        ppi = @"264";
    }
    return ppi;
}

- (CGSize)resolution
{
    CGSize resolution = CGSizeZero;
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        resolution = CGSizeMake(320, 480);
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        resolution = CGSizeMake(640, 960);
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,4"]) {
        
        resolution = CGSizeMake(640, 1136);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"] ||
             [self.deviceName isEqualToString:@"iPhone8,2"]) {
        resolution = CGSizeMake(1080, 1920);
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"] ||
             [self.deviceName isEqualToString:@"iPhone8,1"]) {
        resolution = CGSizeMake(750, 1334);
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        resolution = CGSizeMake(768, 1024);
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        resolution = CGSizeMake(1536, 2048);
    }
    else {
        resolution = CGSizeMake(640, 960);
    }
    return resolution;
}

- (NSString *)appVersion
{
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (CGFloat)latitude
{
    return [ABLocationManager sharedInstance].currentLocation.coordinate.latitude;
}

- (CGFloat)longitude
{
    return [ABLocationManager sharedInstance].currentLocation.coordinate.longitude;
}


@end
