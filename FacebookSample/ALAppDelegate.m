//  Copyright (c) 2012年 Tomohiko Himura. All rights reserved.
//  http://eiel.info/
//  http://ios.eiel.info/Facebook


#import "ALAppDelegate.h"

// https://developers.facebook.com/apps/ にてアプリケーション作成し、App IDを取得する
static NSString* FACEBOOK_APP_ID = @"APP_ID";

@implementation ALAppDelegate

@synthesize window = i_window;
@synthesize facebook = i_facebook;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // APP_ID はfacebookのデベローパーページのアプリケーションの登録をする必要があります。
    i_facebook = [[Facebook alloc] initWithAppId:FACEBOOK_APP_ID andDelegate:self];

    // 保存してあるアクセストークンがあればとりだす。
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        i_facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        i_facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }

    if (![i_facebook isSessionValid]) {
        // その他の権限 https://developers.facebook.com/docs/authentication/permissions/
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                // @"read_stream",
                                @"publish_actions",
                                nil];
        [i_facebook authorize:permissions];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [i_facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [i_facebook handleOpenURL:url]; 
}

#pragma mark - FBSessionDelegate
- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[i_facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[i_facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

- (void)fbDidExtendToken:(NSString*)accessToken expiresAt:(NSDate*)expiresAt
{
    NSLog(@"token extended");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

@end
