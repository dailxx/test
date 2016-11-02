//
//  ABServiceFactory.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABServiceFactory.h"
#import "TestService.h"

@interface ABServiceFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation ABServiceFactory

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static ABServiceFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ABServiceFactory alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods
- (ABService<ABServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier
{
    if (self.serviceStorage[identifier] == nil) {
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    return self.serviceStorage[identifier];
}

#pragma mark - private methods
- (ABService<ABServiceProtocal> *)newServiceWithIdentifier:(NSString *)identifier
{
    if ([identifier isEqualToString:kABServiceTest]) {
        return [[TestService alloc] init];
    }
    return nil;
}

@end
