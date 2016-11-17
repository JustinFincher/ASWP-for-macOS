//
//  AppDelegate.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "AppDelegate.h"
#import "JZWallPaperMainViewController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic,strong) NSPopover *popOver;
@property (nonatomic,strong) NSStatusItem *statusItem;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:-2];
    NSStatusBarButton *itemButton = self.statusItem.button;
    itemButton.image = [NSImage imageNamed:@"StatusBarButtonImage"];
    itemButton.action = @selector(togglePopover:);
    self.popOver = [[NSPopover alloc] init];
    self.popOver.contentViewController = [[JZWallPaperMainViewController alloc] initWithNibName:@"JZWallPaperMainViewController" bundle:[NSBundle mainBundle]];
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
    [self.popOver showRelativeToRect:self.statusItem.button.bounds ofView:self.statusItem.button preferredEdge:NSMinYEdge];
}
- (void)closePopover:(id)sender
{
    [self.popOver performClose:sender];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
