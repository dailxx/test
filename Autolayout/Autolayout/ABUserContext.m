//
//  UserContext.m
//  TTProject
//
//  Created by 张志恒 on 16/8/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABUserContext.h"

static NSString *const kArchiveFileName = @"UserContext.archive";
static NSString *const kArchiveKey      = @"UserContext";

@implementation ABUserContext

+ (instancetype)sharedInstance
{
    static ABUserContext *userContext = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userContext = [ABUserContext getEncodeData];
    });
    return userContext;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.sessionId forKey:@"Session"];
    [aCoder encodeObject:self.empId forKey:@"EmpId"];
    [aCoder encodeObject:self.empName forKey:@"EmpName"];
    [aCoder encodeObject:self.account forKey:@"Account"];
    [aCoder encodeObject:self.userKey forKey:@"UserKey"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.sessionId = [aDecoder decodeObjectForKey:@"Session"];
        self.empId     = [aDecoder decodeObjectForKey:@"EmpId"];
        self.empName   = [aDecoder decodeObjectForKey:@"EmpName"];
        self.account   = [aDecoder decodeObjectForKey:@"Account"];
        self.userKey   = [aDecoder decodeObjectForKey:@"UserKey"];
    }
    return self;
}

+ (ABUserContext *)getEncodeData
{
    NSString *filePath = [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data.length > 0) {
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        ABUserContext *user = [unArchiver decodeObjectForKey:kArchiveKey];
        [unArchiver finishDecoding];
        
        return user;
    } else {
        ABUserContext *user = [[ABUserContext alloc] init];
        return user;
    }
}

- (BOOL)archiveData
{
    NSMutableData *encodeData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:encodeData];
    [archiver encodeObject:self forKey:kArchiveKey];
    [archiver finishEncoding];
    
    NSString *filePath = [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
    return [encodeData writeToFile:filePath atomically:YES];
}

- (BOOL)resetArchiveData
{
    self.sessionId = @"";
    self.empId     = @"";
    self.empName   = @"";
    self.account   = @"";
    self.userKey   = @"";
    
    return [self archiveData];
}

+ (NSString *)filePath
{
    return [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nsessionId:%@\nempId:%@\nempName:%@\naccount:%@\nuserKey:%@", self.sessionId, self.empId, self.empName, self.account, self.userKey];
}

@end
