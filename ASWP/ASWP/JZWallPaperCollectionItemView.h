//
//  JZWallPaperCollectionItemView.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class JZWallPaperCollectionItemView;
@protocol JZWallPaperCollectionItemViewMouseDelegate <NSObject>
@optional
- (void)mouseInWithSender:(JZWallPaperCollectionItemView *)sender
                    event:(NSEvent *)theEvent;
- (void)mouseOutWithSender:(JZWallPaperCollectionItemView *)sender
                     event:(NSEvent *)theEvent;
- (void)mouseRightClickWithSender:(JZWallPaperCollectionItemView *)sender
                            event:(NSEvent *)theEvent;
@end

@interface JZWallPaperCollectionItemView : NSView

@property (nonatomic, weak) id <JZWallPaperCollectionItemViewMouseDelegate> mouseDelegate;

@end
