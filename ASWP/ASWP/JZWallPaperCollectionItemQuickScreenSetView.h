//
//  JZWallPaperCollectionItemQuickScreenSetView.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@class JZWallPaperCollectionItemQuickScreenSetView;
@protocol JZWallPaperCollectionItemQuickScreenSetViewDelegate <NSObject>
@optional
- (void)smashThatButtonWithScreen:(NSScreen *)screen;
@end

@interface JZWallPaperCollectionItemQuickScreenSetView : NSView

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, weak) id <JZWallPaperCollectionItemQuickScreenSetViewDelegate> delegate;
@end
