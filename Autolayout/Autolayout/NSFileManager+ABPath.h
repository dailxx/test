//
//  NSFileManager+ABPath.h
//  TTProject
//
//  Created by 张志恒 on 16/8/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ABPath)
/**
 Get path of Documents directory.
 
 @return Documents directory path.
 */
+ (NSString *)ab_documentsPath;
/**
 Get path of Library directory.
 
 @return Library directory path.
 */
+ (NSString *)ab_libraryPath;
/**
 Get path of Caches directory.
 
 @return Caches directory path.
 */
+ (NSString *)ab_cachesPath;
@end
