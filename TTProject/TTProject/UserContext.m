//
//  UserContext.m
//  TTProject
//
//  Created by 张志恒 on 16/8/26.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "UserContext.h"

static NSString *const kArchiveFileName = @"UserContext.archive";
static NSString *const kArchiveKey      = @"UserContext";

@implementation UserContext

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

+ (UserContext *)getEncodeData
{
    NSString *filePath = [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data.length > 0) {
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        UserContext *user = [unArchiver decodeObjectForKey:kArchiveKey];
        [unArchiver finishDecoding];
        
        return user;
    } else {
        UserContext *user = [[UserContext alloc] init];
        return user;
    }
}

+ (BOOL)archiveWithData:(UserContext *)user
{
    NSMutableData *encodeData = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:encodeData];
    [archiver encodeObject:user forKey:kArchiveKey];
    [archiver finishEncoding];
    
    NSString *filePath = [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
    return [encodeData writeToFile:filePath atomically:YES];
}

+ (BOOL)resetArchiveData:(UserContext *)user
{
    user.sessionId = @"";
    user.empId     = @"";
    user.empName   = @"";
    user.account   = @"";
    user.userKey   = @"";
    
    return [UserContext archiveWithData:user];
}

+ (NSString *)filePath
{
    return [[NSFileManager ab_documentsPath] stringByAppendingPathComponent:kArchiveFileName];
}

+ (void)openArchiveData:(UserContext *__autoreleasing *)user
{
    *user = [UserContext getEncodeData];
    
    [*user addObserver:*user
            forKeyPath:@"sessionId"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:(__bridge void *)([UserContext class])];
    [*user addObserver:*user
            forKeyPath:@"empId"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:(__bridge void *)([UserContext class])];
    [*user addObserver:*user
            forKeyPath:@"empName"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:(__bridge void *)([UserContext class])];
    [*user addObserver:*user
            forKeyPath:@"account"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:(__bridge void *)([UserContext class])];
    [*user addObserver:*user
            forKeyPath:@"userKey"
               options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
               context:(__bridge void *)([UserContext class])];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
}

@end
