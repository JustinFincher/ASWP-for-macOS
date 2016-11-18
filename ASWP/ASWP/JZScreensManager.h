//
//  JZScreensManager.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface JZScreensManager : NSObject
+ (id)sharedManager;
- (NSMutableArray *)currentScreens;
@end

@interface JZScreensModel : NSObject

@property (nonatomic,strong) NSString *screenDescription;
@property (nonatomic,strong) NSScreen *screen;

@end
