//
//  ABApiProxy.h
//  TTProject
//
//  Created by 张志恒 on 16/9/19.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABURLResponse.h"

typedef void(^ABCallback)(ABURLResponse *response);

@interface ABApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ABCallback)success
                          fail:(ABCallback)fail;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params
              serviceIdentifier:(NSString *)servieIdentifier
                     methodName:(NSString *)methodName
                        success:(ABCallback)success
                           fail:(ABCallback)fail;

- (NSInteger)callPUTWithParams:(NSDictionary *)params
             serviceIdentifier:(NSString *)servieIdentifier
                    methodName:(NSString *)methodName
                       success:(ABCallback)success
                          fail:(ABCallback)fail;

- (NSInteger)callDELETEWithParams:(NSDictionary *)params
                serviceIdentifier:(NSString *)servieIdentifier
                       methodName:(NSString *)methodName
                          success:(ABCallback)success
                             fail:(ABCallback)fail;

- (NSNumber *)callApiWithRequest:(NSURLRequest *)request
                         success:(ABCallback)success
                            fail:(ABCallback)fail;


- (void)cancelRequestWithRequestID:(NSNumber *)requestID;
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

@end
