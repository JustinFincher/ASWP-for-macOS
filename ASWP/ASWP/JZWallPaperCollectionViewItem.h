//
//  JZWallPaperCollectionViewItem.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JZWallPaperCollectionItemView.h"

@interface JZWallPaperCollectionViewItem : NSCollectionViewItem
@property (weak) IBOutlet NSImageView *artworkImageView;
@property (strong, nonatomic) NSURL *artworkImageUrl;

@property (strong, nonatomic) NSURL *artworkUrl;

@property (weak) IBOutlet NSTextField *titleLabel;
@property (strong, nonatomic) NSString *artworkTitle;

@property (weak) IBOutlet NSTextField *timeLabel;
@property (strong, nonatomic) NSDate *artworkDate;
@end
