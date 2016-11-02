//
//  NSDictionary+ABNetworkingAddtions.h
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ABNetworkingAddtions)

- (NSString *)AB_urlParamsStringSignature:(BOOL)isForSignature;
- (NSString *)AB_jsonString;
- (NSArray *)AB_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
