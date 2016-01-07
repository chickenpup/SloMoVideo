//
//  AppDelegate.m
//  SloMoVideo
//
//  Created by Chris on 9/23/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import "AppDelegate.h"
#import "MediaLibrary.h"
#import "PasscodeServices.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Inform the device that we want to use the device orientation.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    /// Get video files without GCD
    //[[MediaLibrary sharedLibrary] initialPullFromDocuments];
    
    /// Using async serial queue. At the moment, this seems to offer fastest launch time. Speed differences
    /// start becoming apparent around the 70 video mark.
    dispatch_queue_t mediaLibraryQueue = dispatch_queue_create("media library queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(mediaLibraryQueue, ^{
        [[MediaLibrary sharedLibrary] initialPullFromDocuments];
    });
    
    /// Using global concurrent queue
    //            dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
    //            [[MediaLibrary sharedLibrary] initialPullFromDocuments];
    //         });
    
    
    /// Check if this is the app's first launch. If so, set a BOOL in the first view controller that is checked in viewDidAppear and controls whether the user is prompted to enable a passcode for the app.
    //    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
    //        UINavigationController *rootVC = (UINavigationController*)self.window.rootViewController;
    //        CameraViewController *visibleViewController = (CameraViewController*)rootVC.visibleViewController;
    //
    //        visibleViewController.shouldPromptForPasscodeCreation = YES;
    //
    //
    //
    //        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
    //        [[NSUserDefaults standardUserDefaults] synchronize];
    //}
    
    //else {
    //
    //}
    //
    
    UINavigationController *rootVC = (UINavigationController*)self.window.rootViewController;
    
    UIViewController *visibleVC = (UIViewController<PasscodeAlertControllerHandling>*)rootVC.visibleViewController;
    
    if ([PasscodeServices touchIDEnabled]) {
        //[PasscodeServices promptForTouchID];
        [PasscodeServices promptForPasscodeInViewController:visibleVC];

    }
    
    else if ([PasscodeServices passcodeEnabled]) {
        [PasscodeServices promptForPasscodeInViewController:visibleVC];
    }
    

        
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UINavigationController *rootVC = (UINavigationController*)self.window.rootViewController;
    
    UIViewController *visibleVC = (UIViewController<PasscodeAlertControllerHandling>*)rootVC.visibleViewController;
   
    if ([PasscodeServices touchIDEnabled]) {
        //    LAContext *myContext = [[LAContext alloc] init];
        //    NSError *authError = nil;
        //    NSString *myLocalizedReasonString = @"String explaining why app needs authentication";
        //
        //    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        //        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
        //                  localizedReason:myLocalizedReasonString
        //                            reply:^(BOOL success, NSError *error) {
        //                                if (success) {
        //                                    NSLog(@"success");
        //                                } else {
        //                                    NSLog(@"something went wrong");
        //                                }
        //                            }];
        //    } else {
        //        // Could not evaluate policy; look at authError and present an appropriate message to user
        //    }
        //

        //[PasscodeServices promptForTouchID];
        [PasscodeServices promptForPasscodeInViewController:visibleVC];

    }
    
    else if ([PasscodeServices passcodeEnabled]) {
        [PasscodeServices promptForPasscodeInViewController:visibleVC];
    }
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
