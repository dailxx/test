//
//  ABServiceFactory.h
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABService.h"

@interface ABServiceFactory : NSObject

+ (instancetype)sharedInstance;

- (ABService<ABServiceProtocal> *)serviceWithIdentifier:(NSString *)identifier;

@end
