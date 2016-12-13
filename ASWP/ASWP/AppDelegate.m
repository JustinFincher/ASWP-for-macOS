//
//  AppDelegate.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "AppDelegate.h"
#import "JZWallPaperMainViewController.h"
#import "StartAtLoginController.h"
#import <ServiceManagement/ServiceManagement.h>
#import <HockeySDK/HockeySDK.h>

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"7bc790505bd142bba55522d02e2ab18a"];
    // Do some additional configuration if needed here
    [[BITHockeyManager sharedHockeyManager] startManager];

    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:-2];
    NSStatusBarButton *itemButton = self.statusItem.button;
    itemButton.image = [NSImage imageNamed:@"StatusBarButtonImage"];
    itemButton.action = @selector(togglePopover:);
    self.popOver = [[NSPopover alloc] init];
    self.popOver.behavior = NSPopoverBehaviorTransient;
    self.popOver.contentViewController = [[JZWallPaperMainViewController alloc] initWithNibName:@"JZWallPaperMainViewController" bundle:[NSBundle mainBundle]];
    [[NSNotificationCenter defaultCenter] addObserver : self selector:@selector (resignKey:) name:NSWindowDidResignKeyNotification object: self.popOver.contentViewController.view.window ];
}

- (void)resignKey:(NSNotification *)notification
{
    [self.popOver performClose:self];
}

- (void)togglePopover:(id)sender
{
    if ([self.popOver isShown])
    {
        [self closePopover:sender];
    }else
    {
        [self showPopover:sender];
    }
}
- (void)showPopover:(id)sender
{
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    [self.popOver showRelativeToRect:self.statusItem.button.bounds ofView:self.statusItem.button preferredEdge:NSMinYEdge];
}
- (void)closePopover:(id)sender
{
    [[NSApplication sharedApplication] activateIgnoringOtherApps:NO];
    [self.popOver performClose:sender];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
