//
//  ABRequestGenerator.h
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                             requestParams:(NSDictionary *)requestParams
                                                methodName:(NSString *)methodName;

- (NSURLRequest *)generatePUTRequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                            requestParams:(NSDictionary *)requestParams
                                               methodName:(NSString *)methodName;

- (NSURLRequest *)generateDELETERequestWithServiceIdentifier:(NSString *)serviceIdentifier
                                               requestParams:(NSDictionary *)requestParams
                                                  methodName:(NSString *)methodName;

@end
