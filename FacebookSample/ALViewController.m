//  Copyright (c) 2012年 Tomohiko Himura. All rights reserved.
//  http://eiel.info/
//  http://ios.eiel.info/Facebook

#import "ALViewController.h"
#import "ALAppDelegate.h"

@interface ALViewController ()
{
    UIAlertView* i_alert;
}
@end

@implementation ALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)tapButton:(id)sender {
    ALAppDelegate* delegate = (id)[UIApplication sharedApplication].delegate;
    Facebook* facebook = delegate.facebook;
    
    // API リファレンス https://developers.facebook.com/docs/reference/api/
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"テスト書き込み", @"message", // フィードヘかきこむ内容
     nil];
    [facebook requestWithGraphPath:@"feed"
                         andParams:params
                     andHttpMethod:@"POST"
                       andDelegate:self];
}

#pragma mark - FBRequestDelegate
- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"投稿しました。");
    i_alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Facebookにシェアしました。"
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [i_alert show];
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"投稿に失敗しました。");
    NSLog(@"%@", error);
    i_alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Facebookにシェアに失敗しました。"
                                        delegate:nil
                               cancelButtonTitle:@"OK"
                               otherButtonTitles:nil];
    [i_alert show];
}

@end
