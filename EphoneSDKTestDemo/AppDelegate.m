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

    
    return YES;
}



@end
