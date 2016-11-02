//
//  ABLocationManager.m
//  TTProject
//
//  Created by 张志恒 on 16/9/20.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ABLocationManager.h"

@interface ABLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, assign, readwrite) ABLocationManagerLocationResult locationResult;
@property (nonatomic, assign, readwrite) ABLocationManagerLocationServiceStatus locationStatus;
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ABLocationManager

+ (instancetype)sharedInstance
{
    static ABLocationManager *locationManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[ABLocationManager alloc] init];
    });
    return locationManager;
}

#pragma mark - public methods
- (void)startLocation
{
    if ([self checkLocationStatus]) {
        self.locationResult = ABLocationManagerLocationResultLocating;
        [self.locationManager startUpdatingLocation];
    } else {
        [self failedLocationWithResultType:ABLocationManagerLocationResultFail statusType:self.locationStatus];
    }
}

- (void)stopLocation
{
    if ([self checkLocationStatus]) {
        [self.locationManager stopUpdatingLocation];
    }
}

- (void)restartLocation
{
    [self stopLocation];
    [self startLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.currentLocation = [manager.location copy];
    [self stopLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //如果用户还没选择是否允许定位，则不认为是定位失败
    if (self.locationStatus == ABLocationManagerLocationServiceStatusNotDetermined) {
        return;
    }
    
    //如果正在定位中，那么也不会通知到外面
    if (self.locationResult == ABLocationManagerLocationResultLocating) {
        return;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.locationStatus = ABLocationManagerLocationServiceStatusOK;
        [self restartLocation];
    } else {
        if (self.locationStatus != ABLocationManagerLocationServiceStatusNotDetermined) {
            [self failedLocationWithResultType:ABLocationManagerLocationResultDefault statusType:ABLocationManagerLocationServiceStatusNoAuthorization];
        } else {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager startUpdatingLocation];
        }
    }
    
}

#pragma mark - private methods
- (void)failedLocationWithResultType:(ABLocationManagerLocationResult)result statusType:(ABLocationManagerLocationServiceStatus)status
{
    self.locationResult = result;
    self.locationStatus = status;
}

- (BOOL)checkLocationStatus
{
    BOOL result = NO;
    BOOL serviceEnable = [self locationServiceEnabled];
    ABLocationManagerLocationServiceStatus authorizationStatus = [self locationServiceStatus];
    if (authorizationStatus == ABLocationManagerLocationServiceStatusOK && serviceEnable) {
        result = YES;
    }else if (authorizationStatus == ABLocationManagerLocationServiceStatusNotDetermined) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (serviceEnable && result) {
        result = YES;
    }else{
        result = NO;
    }
    
    if (result == NO) {
        [self failedLocationWithResultType:ABLocationManagerLocationResultFail statusType:self.locationStatus];
    }
    
    return result;
}

- (BOOL)locationServiceEnabled
{
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationStatus = ABLocationManagerLocationServiceStatusOK;
        return YES;
    } else {
        self.locationStatus = ABLocationManagerLocationServiceStatusUnknownError;
        return NO;
    }
}

- (ABLocationManagerLocationServiceStatus)locationServiceStatus
{
    self.locationStatus = ABLocationManagerLocationServiceStatusUnknownError;
    BOOL serviceEnable = [CLLocationManager locationServicesEnabled];
    if (serviceEnable) {
        CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
        switch (authorizationStatus) {
            case kCLAuthorizationStatusNotDetermined:
                self.locationStatus = ABLocationManagerLocationServiceStatusNotDetermined;
                break;
                
            case kCLAuthorizationStatusAuthorizedAlways :
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                self.locationStatus = ABLocationManagerLocationServiceStatusOK;
                break;
                
            case kCLAuthorizationStatusDenied:
                self.locationStatus = ABLocationManagerLocationServiceStatusNoAuthorization;
                break;
                
            default:
                break;
        }
    } else {
        self.locationStatus = ABLocationManagerLocationServiceStatusUnAvailable;
    }
    return self.locationStatus;
}



#pragma mark - getters and setters
- (CLLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

@end
