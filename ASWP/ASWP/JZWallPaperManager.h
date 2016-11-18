//
//  JZWallPaperManager.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
@interface JZWallPaperManager : NSObject

+ (id)sharedManager;

- (void)setWallPaper:(NSImage *)image
          WithScreen:(NSScreen *)screen
     completeHandler:(void (^)(void))completion;

- (void)saveWallPaper:(NSImage *)image
      completeHandler:(void (^)(void))completion;

@end
