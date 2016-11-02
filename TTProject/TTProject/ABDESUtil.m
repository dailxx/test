//
//  DESUtils.m
//  TT
//
//  Created by 张志恒 on 16/3/7.
//  Copyright © 2016年 张志恒. All rights reserved.
//

#import "ABDESUtil.h"
#import "NSData+ABBase64.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation ABDESUtil

+ (NSString *)encrypt:(NSString *)plainText withKey:(NSString *)key andIV:(NSString *)iv{
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [iv UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,                                   // 加密或解密
                       kCCAlgorithmDES,                              // 加密算法
                       (kCCOptionPKCS7Padding | kCCOptionECBMode),   // padding规则
                       vkey,                                         // 密匙
                       kCCKeySizeDES,                                // 密匙长度
                       vinitVec,                                     // 可选的初始矢量
                       vplainText,                                   // 加密的数据
                       plainTextBufferSize,                          // 加密数据的大小
                       (void *)bufferPtr,                            // 加密结果(dataOut)
                       bufferPtrSize,                                // dataOut的大小
                       &movedBytes);                                 // 实际写入dataOut的数据长度
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    
    return [myData ab_base64EncodedString];
}

+ (NSString *)decrypt:(NSString *)encryptText withKey:(NSString *)key andIV:(NSString *)iv{
    NSData *encryptData = [NSData ab_dataWithBase64EncodedString:encryptText];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [iv UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       (kCCOptionPKCS7Padding | kCCOptionECBMode),
                       vkey,
                       kCCKeySizeDES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *dataOutMoved = [NSData dataWithBytes:bufferPtr length:movedBytes];
    NSString *result = [[NSString alloc] initWithData:dataOutMoved encoding:NSUTF8StringEncoding];
    
    return result;
}

@end





























