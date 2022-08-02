//
//  AppDelegate.m
//  EphoneSDKTestDemo
//
//  Created by 王丽珍 on 2020/12/9.
//

#import "AppDelegate.h"
#import "YFBluetoothScanViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    YFBluetoothScanViewController *mainView = [[YFBluetoothScanViewController alloc]init];

    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mainView];

    navi.navigationBar.backgroundColor = [UIColor whiteColor];

    [self.window setRootViewController:navi];

    [self.window makeKeyAndVisible];
    
    [self getGetAccessToken];
    
    [YFUncaughtExceptionHandler setDefaultHandler];
    
//    [self exceptionHandler];
    
    
    return YES;
}

- (void)getGetAccessToken {
    WEAKSELF;
    [YFDeviceAPIHelpers YFGetAccessTokenWithAppid:@"62187baa88a1c91b2c18cbd1" secret:@"c21f523dadcd459082397022e01de606" grantType:@"client_credential" success:^(id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", responseObject);
            weakSelf.access_token = responseObject[@"access_token"];
        });
        
    } failure:^(NSError *error, NSString *errorDes) {
        NSLog(@"%@,%@",error, errorDes);
        [SVProgressHUD showErrorWithText:@"获取accessToken失败"];
    }];
}


#pragma mark - 崩溃日志
- (void)exceptionHandler {
    //崩溃日志
    [YFUncaughtExceptionHandler setDefaultHandler];
    //获取崩溃日志,然后发送
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [path stringByAppendingPathComponent:@"crash.txt"];
    NSData *data = [NSData dataWithContentsOfFile:dataPath];
    
    NSString *error = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (data != nil) {
        //发送崩溃日志
        NSLog(@"crash:%@, error:%@",data,error);
    }
}



@end
