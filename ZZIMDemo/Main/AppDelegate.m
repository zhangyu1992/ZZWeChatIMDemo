//
//  AppDelegate.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/4.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZWebSocketUtility.h"
#import "CYLTabBarController.h"
#import "ZZWeChatViewController.h"
#import "ZZAddressBookViewController.h"
#import "JTNavigationController.h"
@interface AppDelegate ()
@property (nonatomic, strong) CYLTabBarController * tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[ZZWebSocketUtility shareInstance] connectWebSocket];
    [self setupViewControllers];
  
    [self.window setRootViewController:self.tabBarController];

    return YES;
}
- (void)setupViewControllers {
    ZZWeChatViewController *firstViewController = [[ZZWeChatViewController alloc] init];
    JTNavigationController *firstNavigationController = [[JTNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    ZZAddressBookViewController *secondViewController = [[ZZAddressBookViewController alloc] init];
    JTNavigationController *secondNavigationController = [[JTNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    ZZAddressBookViewController *findViewController = [[ZZAddressBookViewController alloc] init];
    JTNavigationController *findNavigationController = [[JTNavigationController alloc]
                                                          initWithRootViewController:findViewController];
    
    ZZAddressBookViewController *mineViewController = [[ZZAddressBookViewController alloc] init];
    JTNavigationController *mineNavigationController = [[JTNavigationController alloc]
                                                          initWithRootViewController:mineViewController];
    
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,findNavigationController,mineNavigationController
                                           ]];
    self.tabBarController = tabBarController;
}
/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"微信",
                            CYLTabBarItemImage : @"duanxin-4",
                            CYLTabBarItemSelectedImage : @"duanxin-3",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"通讯录",
                            CYLTabBarItemImage : @"wenben-4",
                            CYLTabBarItemSelectedImage : @"wenben-3",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"xianshi-4",
                            CYLTabBarItemSelectedImage : @"xianshi-3",
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"ren-4",
                            CYLTabBarItemSelectedImage : @"ren-3",
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 ,dict3,dict4];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
