//  Copyright (c) 2012年 Tomohiko Himura. All rights reserved.
//  http://eiel.info/
//  http://ios.eiel.info/Facebook

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@interface ALAppDelegate : UIResponder <UIApplicationDelegate, FBSessionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;

@end
