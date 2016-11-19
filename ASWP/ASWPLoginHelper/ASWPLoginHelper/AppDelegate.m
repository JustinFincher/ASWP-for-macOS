//
//  AppDelegate.m
//  ASWPLoginHelper
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "AppDelegate.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;


@property (strong) NSTimer *timer;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    // Check if main app is already running; if yes, do nothing and terminate helper app
//    BOOL alreadyRunning = NO;
//    BOOL isActive = NO; // my modification
//    NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
//    for (NSRunningApplication *app in running) {
//        if ([[app bundleIdentifier] isEqualToString:@"com.JustZht.ASWP"]) {
//            alreadyRunning = YES;
//            isActive = [app isActive]; // my modification
//            break;
//        }
//    }
//    
//    if (!alreadyRunning || !isActive) { // my modification
//        NSString *path = [[NSBundle mainBundle] bundlePath];
//        NSArray *p = [path pathComponents];
//        NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:p];
//        [pathComponents removeLastObject];
//        [pathComponents removeLastObject];
//        [pathComponents removeLastObject];
//        [pathComponents addObject:@"MacOS"];
//        [pathComponents addObject:@"ArtWall"];
//        NSString *newPath = [NSString pathWithComponents:pathComponents];
//        NSLog(@"%@",newPath);
//        [[NSWorkspace sharedWorkspace] launchApplication:newPath];
//    }
//    [NSApp terminate:nil];

    NSString *appPath = [[[[[[NSBundle mainBundle] bundlePath] stringByDeletingLastPathComponent] stringByDeletingLastPathComponent]  stringByDeletingLastPathComponent] stringByDeletingLastPathComponent];
    // get to the waaay top. Goes through LoginItems, Library, Contents, Applications
    [[NSWorkspace sharedWorkspace] launchApplication:appPath];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(ticktock) userInfo:nil repeats:YES];
//    [NSApp terminate:nil];
}

- (void)ticktock
{
    NSLog(@"ArtWall Login Launch Helper Tick Tock");
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [self.timer invalidate];
}


@end
