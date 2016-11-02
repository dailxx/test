//
//  ABLocationManager.h
//  TTProjeAB
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, ABLocationManagerLocationServiceStatus) {
    ABLocationManagerLocationServiceStatusDefault,               //默认状态
    ABLocationManagerLocationServiceStatusOK,                    //定位功能正常
    ABLocationManagerLocationServiceStatusUnknownError,          //未知错误
    ABLocationManagerLocationServiceStatusUnAvailable,           //定位功能关掉了
    ABLocationManagerLocationServiceStatusNoAuthorization,       //定位功能打开，但是用户不允许使用定位
    ABLocationManagerLocationServiceStatusNoNetwork,             //没有网络
    ABLocationManagerLocationServiceStatusNotDetermined          //用户还没做出是否要允许应用使用定位功能的决定，第一次安装应用的时候会提示用户做出是否允许使用定位功能的决定
};

typedef NS_ENUM(NSUInteger, ABLocationManagerLocationResult) {
    ABLocationManagerLocationResultDefault,              //默认状态
    ABLocationManagerLocationResultLocating,             //定位中
    ABLocationManagerLocationResultSuccess,              //定位成功
    ABLocationManagerLocationResultFail,                 //定位失败
    ABLocationManagerLocationResultParamsError,          //调用API的参数错了
    ABLocationManagerLocationResultTimeout,              //超时
    ABLocationManagerLocationResultNoNetwork,            //没有网络
    ABLocationManagerLocationResultNoContent             //API没返回数据或返回数据是错的
};

@interface ABLocationManager : NSObject

@property (nonatomic, assign, readonly) ABLocationManagerLocationResult locationResult;
@property (nonatomic, assign, readonly) ABLocationManagerLocationServiceStatus locationStatus;
@property (nonatomic, strong, readonly) CLLocation *currentLocation;

+ (instancetype)sharedInstance;

- (void)startLocation;
- (void)stopLocation;
- (void)restartLocation;

@end
