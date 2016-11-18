//
//  JZWallPaperCollectionItemView.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperCollectionItemView.h"
@interface JZWallPaperCollectionItemView()

@property (strong, nonatomic) NSTrackingArea *trackingArea;
@property (assign, nonatomic) BOOL mouseInside;

@end

@implementation JZWallPaperCollectionItemView

- (void)awakeFromNib
{
}

- (void) updateTrackingAreas {
    [super updateTrackingAreas];
    
    [self ensureTrackingArea];
    if (![[self trackingAreas] containsObject:_trackingArea]) {
        [self addTrackingArea:_trackingArea];
    }
}

- (void) ensureTrackingArea {
    if (_trackingArea == nil) {
        self.trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
                                                         options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited
                                                           owner:self
                                                        userInfo:nil];
    }
}

- (void) mouseEntered:(NSEvent *)theEvent
{
    self.mouseInside = YES;
    [self.mouseDelegate mouseInWithSender:self event:theEvent];
}

- (void) mouseExited:(NSEvent *)theEvent
{
    self.mouseInside = NO;
    [self.mouseDelegate mouseOutWithSender:self event:theEvent];
}
- (void) rightMouseDown: (NSEvent*) theEvent
{
    [self.mouseDelegate mouseRightClickWithSender:self event:theEvent];
}
- (void) setMouseInside:(BOOL)value {
    if (_mouseInside != value) {
        _mouseInside = value;
        [self setNeedsDisplay:YES];
    }
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

@end
