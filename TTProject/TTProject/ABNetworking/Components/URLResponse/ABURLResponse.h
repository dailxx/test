//
//  ABURLResponse.h
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABNetworkingConfig.h"

typedef NS_ENUM(NSUInteger, ABURLResponseStatus)
{
    ABURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的CTAPIBaseManager来决定。
    ABURLResponseStatusErrorTimeout,
    ABURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
};

@interface ABURLResponse : NSObject

@property (nonatomic, assign, readonly) ABURLResponseStatus status;
@property (nonatomic, copy, readonly) NSString *responseString;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, strong, readonly) id content;
@property (nonatomic, strong, readonly) NSURLRequest *request;
@property (nonatomic, strong, readonly) NSData *responseData;
@property (nonatomic, strong) NSDictionary *requestParams;
@property (nonatomic, assign, readonly) BOOL isCache;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(ABURLResponseStatus)status;

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

- (instancetype)initWithData:(NSData *)data;

@end
