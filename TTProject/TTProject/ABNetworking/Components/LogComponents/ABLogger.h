//
//  ABLogger.h
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABURLResponse.h"
#import "ABService.h"

@interface ABLogger : NSObject

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request
                     methodName:(NSString *)apiName
                        service:(ABService *)service
                  requestParams:(id)requestParams
                     httpMethod:(NSString *)httpMethod;

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response
                   resposeString:(NSString *)responseString
                         request:(NSURLRequest *)request
                           error:(NSError *)error;

+ (void)logDebugInfoWithCachedResponse:(ABURLResponse *)response
                            methodName:(NSString *)methodName
                               service:(ABService *)service;

+ (instancetype)sharedInstance;

@end
