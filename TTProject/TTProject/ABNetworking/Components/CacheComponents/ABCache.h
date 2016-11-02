//
//  ABCache.h
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABCache : NSObject

+ (instancetype)sharedInstance;

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                  requestParams:(NSDictionary *)requestParams;

- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams;

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                    data:(NSData *)cachedData
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary *)requestParams;
/**
 *  根据给定的key获取内存缓存数据
 *
 *  @param key 给定的key
 *
 *  @return 缓存数据
 */
- (NSData *)fetchCachedDataWithKey:(NSString *)key;
/**
 *  将数据缓存到内存中，使用指定的key
 *
 *  @param cachedData 数据
 *  @param key        指定的key
 */
- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key;
/**
 *  删除指定key对应的缓存数据
 *
 *  @param key 指定的key
 */
- (void)deleteCacheWithKey:(NSString *)key;
/**
 *  清空缓存数据
 */
- (void)clean;

@end
