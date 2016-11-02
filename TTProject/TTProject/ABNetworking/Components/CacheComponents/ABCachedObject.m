//
//  ABCachedObject.m
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABCachedObject.h"
#import "ABNetworkingConfig.h"

@interface ABCachedObject ()

@property (nonatomic, strong, readwrite) NSData *content;
@property (nonatomic, strong, readwrite) NSDate *lastUpdateTime;

@end

@implementation ABCachedObject

#pragma mark - getters and setters
- (BOOL)isEmpty
{
    return self.content == nil;
}

- (BOOL)isOutdated
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    return timeInterval > kABCacheOutdateTimeSeconds;
}

- (void)setContent:(NSData *)content
{
    _content = [content copy];
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSData *)content
{
    self = [super init];
    if (self) {
        self.content = content;
    }
    return self;
}

#pragma mark - public method
- (void)updateContent:(NSData *)content
{
    self.content = content;
}

@end
