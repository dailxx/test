//
//  NSFileManager+ABPath.m
//  TTProject
//
//  Created by 张志恒 on 16/8/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSFileManager+ABPath.h"

@implementation NSFileManager (ABPath)

+ (NSString *)ab_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)ab_documentsPath
{
    return [self ab_pathForDirectory:NSDocumentDirectory];
}

+ (NSString *)ab_libraryPath
{
    return [self ab_pathForDirectory:NSLibraryDirectory];
}

+ (NSString *)ab_cachesPath
{
    return [self ab_pathForDirectory:NSCachesDirectory];
}

@end
