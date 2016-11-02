//
//  NSData+ABAPNSToken.m
//  TTProject
//
//  Created by 张志恒 on 16/8/29.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "NSData+ABAPNSToken.h"

@implementation NSData (ABAPNSToken)

- (NSString *)ab_APNSToken
{
    return [self ab_hexString];
}

@end
