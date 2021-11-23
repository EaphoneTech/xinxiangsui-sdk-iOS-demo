//
//  AppDelegate.m
//  EphoneSDKTestDemo
//
//  Created by 王丽珍 on 2020/12/9.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

    ViewController *mainView = [[ViewController alloc]init];

    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mainView];

    navi.navigationBar.backgroundColor = [UIColor whiteColor];

    [self.window setRootViewController:navi];

    [self.window makeKeyAndVisible];
    
    
    [YFUncaughtExceptionHandler setDefaultHandler];
    
//    [self exceptionHandler];

    
    return YES;
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
