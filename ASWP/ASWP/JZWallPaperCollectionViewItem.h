//
//  JZWallPaperCollectionViewItem.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface JZWallPaperCollectionViewItem : NSCollectionViewItem
@property (weak) IBOutlet NSImageView *artworkImageView;
@property (strong, nonatomic) NSURL *artworkUrl;
@end
