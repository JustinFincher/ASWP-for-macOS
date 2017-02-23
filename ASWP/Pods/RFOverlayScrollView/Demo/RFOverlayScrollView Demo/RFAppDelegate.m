//
//  RFAppDelegate.m
//  RFOverlayScrollView Demo
//
//  Created by Tim Brückmann on 31.12.12.
//  Copyright (c) 2012 Rheinfabrik. All rights reserved.
//

#import "RFAppDelegate.h"
#import "RFOverlayScrollView.h"

@implementation RFAppDelegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 30;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [NSString stringWithFormat:@"Row %ld", row];
}

@end
