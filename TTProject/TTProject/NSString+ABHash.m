//
//  NSString+ABHash.m
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSString+ABHash.h"
#import "NSData+ABHash.h"

@implementation NSString (ABHash)

- (NSString *)ab_md2String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_md2String];
}

- (NSString *)ab_md4String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_md4String];
}

- (NSString *)ab_md5String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_md5String];
}

- (NSString *)ab_sha1String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_sha1String];
}

- (NSString *)ab_sha224String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_sha224String];
}

- (NSString *)ab_sha256String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_sha256String];
}

- (NSString *)ab_sha384String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_sha384String];
}

- (NSString *)ab_sha512String
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_sha512String];
}

- (NSString *)ab_hmacMD5StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacMD5StringWithKey:key];
}

- (NSString *)ab_hmacSHA1StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacSHA1StringWithKey:key];
}

- (NSString *)ab_hmacSHA224StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacSHA224StringWithKey:key];
}

- (NSString *)ab_hmacSHA256StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacSHA256StringWithKey:key];
}

- (NSString *)ab_hmacSHA384StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacSHA384StringWithKey:key];
}

- (NSString *)ab_hmacSHA512StringWithKey:(NSString *)key
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] ab_hmacSHA512StringWithKey:key];
}

@end
