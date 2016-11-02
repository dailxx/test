//
//  ABCache.m
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABCache.h"
#import "ABCachedObject.h"
#import "ABNetworkingConfig.h"
#import "NSDictionary+ABNetworkingAddtions.h"

@interface ABCache ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation ABCache

#pragma mark - getters and setters
- (NSCache *)cache
{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kABCacheCountLimit;
    }
    return _cache;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ABCache *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABCache alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public method
- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                            methodName:(NSString *)methodName
                         requestParams:(NSDictionary *)requestParams

{
    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, methodName, [requestParams AB_urlParamsStringSignature:NO]];
}

- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                      methodName:(NSString *)methodName
                                   requestParams:(NSDictionary *)requestParams
{
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (void)saveCacheWithData:(NSData *)cachedData
        serviceIdentifier:(NSString *)serviceIdentifier
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams
{
    [self saveCacheWithData:cachedData key:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                    data:(NSData *)cachedData
                              methodName:(NSString *)methodName
                           requestParams:(NSDictionary *)requestParams
{
    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key
{
    ABCachedObject *cachedObject = [self.cache objectForKey:key];
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        return nil;
    } else {
        return cachedObject.content;
    }
}

- (void)saveCacheWithData:(NSData *)cachedData key:(NSString *)key
{
    ABCachedObject *cachedObject = [self.cache objectForKey:key];
    if (!cachedObject) {
        cachedObject = [[ABCachedObject alloc] init];
    }
    [cachedObject updateContent:cachedData];
    [self.cache setObject:cachedObject forKey:key];
}

- (void)deleteCacheWithKey:(NSString *)key
{
    [self.cache removeObjectForKey:key];
}

- (void)clean
{
    [self.cache removeAllObjects];
}

@end
