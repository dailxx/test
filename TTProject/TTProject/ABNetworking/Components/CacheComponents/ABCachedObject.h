//
//  ABCachedObject.h
//  TTProject
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABCachedObject : NSObject

@property (nonatomic, strong, readonly) NSData *content;
@property (nonatomic, strong, readonly) NSDate *lastUpdateTime;

@property (nonatomic, assign, readonly) BOOL isOutdated;
@property (nonatomic, assign, readonly) BOOL isEmpty;

- (instancetype)initWithContent:(NSData *)content;

- (void)updateContent:(NSData *)content;

@end
