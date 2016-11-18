//
//  JZScreensModel.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface JZScreensModel : NSObject

@property (nonatomic,strong) NSString *screenDescription;
@property (nonatomic,strong) NSScreen *screen;

@end
