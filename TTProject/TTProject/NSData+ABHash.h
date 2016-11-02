//
//  NSData+ABHash.h
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ABHash)
/**
 Returns a lowercase NSString for md2 hash.
 */
- (NSString *)ab_md2String;

/**
 Returns an NSData for md2 hash.
 */
- (NSData *)ab_md2Data;

/**
 Returns a lowercase NSString for md4 hash.
 */
- (NSString *)ab_md4String;

/**
 Returns an NSData for md4 hash.
 */
- (NSData *)ab_md4Data;

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)ab_md5String;

/**
 Returns an NSData for md5 hash.
 */
- (NSData *)ab_md5Data;

/**
 Returns a lowercase NSString for sha1 hash.
 */
- (NSString *)ab_sha1String;

/**
 Returns an NSData for sha1 hash.
 */
- (NSData *)ab_sha1Data;

/**
 Returns a lowercase NSString for sha224 hash.
 */
- (NSString *)ab_sha224String;

/**
 Returns an NSData for sha224 hash.
 */
- (NSData *)ab_sha224Data;

/**
 Returns a lowercase NSString for sha256 hash.
 */
- (NSString *)ab_sha256String;

/**
 Returns an NSData for sha256 hash.
 */
- (NSData *)ab_sha256Data;

/**
 Returns a lowercase NSString for sha384 hash.
 */
- (NSString *)ab_sha384String;

/**
 Returns an NSData for sha384 hash.
 */
- (NSData *)ab_sha384Data;

/**
 Returns a lowercase NSString for sha512 hash.
 */
- (NSString *)ab_sha512String;

/**
 Returns an NSData for sha512 hash.
 */
- (NSData *)ab_sha512Data;

/**
 Returns a lowercase NSString for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacMD5StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm md5 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacMD5DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacSHA1StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha1 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacSHA1DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacSHA224StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha224 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacSHA224DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacSHA256StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha256 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacSHA256DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacSHA384StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha384 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacSHA384DataWithKey:(NSData *)key;

/**
 Returns a lowercase NSString for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSString *)ab_hmacSHA512StringWithKey:(NSString *)key;

/**
 Returns an NSData for hmac using algorithm sha512 with key.
 @param key  The hmac key.
 */
- (NSData *)ab_hmacSHA512DataWithKey:(NSData *)key;

@end

NS_ASSUME_NONNULL_END