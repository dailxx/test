//
//  ViewController.m
//  Autolayout
//
//  Created by 张志恒 on 16/9/18.
//  Copyright © 2016年 Dail. All rights reserved.
//

#import "ViewController.h"
#import "ABUserContext.h"
#import "SAMKeychain.h"
#import "NSString+ABUUID.h"
#import "Test.h"
#import <objc/runtime.h>
#import "MyView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [ABUserContext sharedInstance].empName = @"zhan32132132g";
    [ABUserContext sharedInstance].empId = @"6903123213";
    [[ABUserContext sharedInstance] archiveData];
    [[ABUserContext sharedInstance] resetArchiveData];
    NSLog(@"%@", [ABUserContext sharedInstance]);
    
    
//    NSError *getError;
//    NSError *setError;
//    /** 设备唯一标识 **/
//    NSString *uuid = [SAMKeychain passwordForService:@"UUID" account:@"autohome"];
//    if (!uuid) {
//        uuid = [NSString ab_UUID];
//        NSLog(@"------%d", [SAMKeychain setPassword:uuid forService:@"UUID" account:@"autohome"]);
//    }
//    
//    NSLog(@"get error:%@", getError);
//    NSLog(@"set error:%@", setError);
    
    NSURL *url = [[NSBundle bundleForClass:[SAMKeychainQuery class]] URLForResource:@"SAMKeychain" withExtension:@"bundle"];
    NSLog(@"%@", url);
//    NSError *error = nil;
//    SAMKeychainQuery *query = [[SAMKeychainQuery alloc] init];
//    query.service = @"UUID";
//    query.account = @"autohome";
//    [query fetch:&error];
//    
//    if ([error code] == errSecItemNotFound) {
//        NSLog(@"Password not found");
//    } else if (error != nil) {
//        NSLog(@"Some other error occurred: %@", [error localizedDescription]);
//    }

}
- (IBAction)btn:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
