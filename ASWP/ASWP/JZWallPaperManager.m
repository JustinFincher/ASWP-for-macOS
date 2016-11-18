//
//  JZWallPaperManager.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperManager.h"
#import <SDWebImage/SDImageCache.h>
@implementation JZWallPaperManager


#pragma mark Singleton Methods

+ (id)sharedManager {
    static JZWallPaperManager *sharedMyManager = nil;
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

- (void)setWallPaper:(NSImage *)image
          WithScreen:(NSScreen *)screen
     completeHandler:(void (^)(void))completion
{
    if (!image)
    {
        return;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDate *date = [NSDate date];
    NSString *fileName = [NSString stringWithFormat:@"%f.jpeg",[date timeIntervalSince1970]];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
    
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
    [imageData writeToFile:filePath atomically:NO];
    
    NSURL *imageUrl = [NSURL fileURLWithPath:filePath];
    
    NSError *error;
    if ([[NSWorkspace sharedWorkspace] setDesktopImageURL:imageUrl forScreen:screen options:[NSDictionary dictionaryWithObjectsAndKeys:@YES,NSWorkspaceDesktopImageAllowClippingKey, nil] error:&error])
    {
        BOOL fileExists = [fileManager fileExistsAtPath:filePath];
        if (fileExists)
        {
//            if (![fileManager removeItemAtPath:filePath error:&error])
//            {
//                NSLog(@"[Error] %@ (%@)", error, filePath);
//            }
        }
        completion();
    }else
    {
        NSLog(@"%@",error.localizedDescription);
    };

}

- (void)saveWallPaper:(NSImage *)image
     completeHandler:(void (^)(void))completion
{
    if (!image)
    {
        return;
    }
    NSSavePanel* panel = [NSSavePanel savePanel];
    panel.styleMask &= ~NSWindowStyleMaskTexturedBackground;
    NSDate *date = [NSDate date];
    NSString *fileName = [NSString stringWithFormat:@"%f.jpeg",[date timeIntervalSince1970]];
    [panel setNameFieldStringValue:fileName];
    [panel beginSheetModalForWindow:[[NSApplication sharedApplication] mainWindow] completionHandler:^(NSInteger result)
    {
        if (result == NSFileHandlingPanelOKButton)
        {
            NSURL*  theFile = [panel URL];
            NSData *imageData = [image TIFFRepresentation];
            NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
            NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
            imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
            [imageData writeToFile:[theFile path] atomically:NO];
            
        }
    }];
}
- (void)clearAllCacheAndSaved
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^(void){}];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtURL:[NSURL fileURLWithPath:cachePath]
                                          includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey]
                                                             options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        errorHandler:^BOOL(NSURL *url, NSError *error)
    {
        if (error) {
            NSLog(@"[Error] %@ (%@)", error, url);
            return NO;
        }
        
        return YES;
    }];
    for (NSURL *fileURL in enumerator)
    {
        NSString *filename;
        [fileURL getResourceValue:&filename forKey:NSURLNameKey error:nil];
        
        NSNumber *isDirectory;
        [fileURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:nil];
        
        NSError *error = nil;
        if (![isDirectory boolValue] && [[fileURL pathExtension] isEqualToString:@"jpeg"])
        {
            if (![fileManager removeItemAtPath:[fileURL path] error:&error])
            {
                NSLog(@"[Error] %@ (%@)", error, [fileURL path]);
            }
        }
    }
    
}
@end
