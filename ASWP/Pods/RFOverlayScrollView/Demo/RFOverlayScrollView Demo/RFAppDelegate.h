//
//  RFAppDelegate.h
//  RFOverlayScrollView Demo
//
//  Created by Tim Brückmann on 31.12.12.
//  Copyright (c) 2012 Rheinfabrik. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class RFOverlayScrollView;

@interface RFAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet RFOverlayScrollView *overlayScrollView;

@end
