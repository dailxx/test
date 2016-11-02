//
//  NSString+ABHash.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ABHash)
/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)ab_md2String;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)ab_md4String;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)ab_md5String;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)ab_sha1String;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)ab_sha224String;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)ab_sha256String;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)ab_sha384String;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)ab_sha512String;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key The hmac key.
 */
- (NSString *)ab_hmacSHA512StringWithKey:(NSString *)key;

@end
