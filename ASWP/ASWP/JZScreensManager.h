//
//  JZScreensManager.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "JZScreensModel.h"

@interface JZScreensManager : NSObject
+ (id)sharedManager;
- (NSMutableArray *)currentScreens;
@end

