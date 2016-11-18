//
//  JZScreensManager.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZScreensManager.h"

@implementation JZScreensManager


#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZScreensManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

- (NSMutableArray *)currentScreens
{
    NSArray *screens = [NSScreen screens];
    NSMutableArray *currentScreens = [NSMutableArray array];
    for (int i = 0; i < screens.count; i ++)
    {
        NSScreen *screen = [screens objectAtIndex:i];
        JZScreensModel *model = [[JZScreensModel alloc] init];
        model.screen = screen;
        model.screenDescription = [NSString stringWithFormat:@"Screen %d : %d×%d",i,(int)screen.frame.size.width,(int)screen.frame.size.height];
        [currentScreens addObject:model];
    }
    return currentScreens;
}
@end
