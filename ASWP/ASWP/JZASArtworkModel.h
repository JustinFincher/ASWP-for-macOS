//
//  JZASArtworkModel.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZASArtworkModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *artworkTitle;
@property (nonatomic,strong) NSString *artworkDescription;
@property (nonatomic,strong) NSURL *artworkLink;
@property (nonatomic,strong) NSURL *artworkImageLink;
@property (nonatomic,strong) NSDate *artworkPubDate;

@end
