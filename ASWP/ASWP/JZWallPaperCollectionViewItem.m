//
//  JZWallPaperCollectionViewItem.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperCollectionViewItem.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DateTools/NSDate+DateTools.h>

@interface JZWallPaperCollectionViewItem ()<JZWallPaperCollectionItemViewMouseDelegate>
@property (weak) IBOutlet NSVisualEffectView *blurView;
@property (strong,nonatomic) NSClickGestureRecognizer *titleClickGestureRecognizeer;
@property (weak) IBOutlet NSView *imageContainerView;

@property (weak) IBOutlet NSProgressIndicator *loadingIndicator;

@end

@implementation JZWallPaperCollectionViewItem

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.blurView.wantsLayer = YES;
    self.blurView.alphaValue = 0.0f;
    self.blurView.hidden = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    self.titleClickGestureRecognizeer = [[NSClickGestureRecognizer alloc] initWithTarget:self action:@selector(openPage:)];
    self.titleClickGestureRecognizeer.buttonMask = 0x1;
    [self.titleLabel addGestureRecognizer:self.titleClickGestureRecognizeer];
    ((JZWallPaperCollectionItemView *)(self.view)).mouseDelegate = self;
}
- (void)setArtworkImageUrl:(NSURL *)artworkImageUrl
{
    _artworkImageUrl = artworkImageUrl;
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimation:self];
    [_artworkImageView sd_setImageWithURL:artworkImageUrl completed:^(NSImage *image, NSError * error, SDImageCacheType cacheType, NSURL *imageURL)
     {
         [self aspectFillWithImage:image];
         [self.loadingIndicator stopAnimation:self];
         [self.loadingIndicator setHidden:YES];
     }];
}

- (void)aspectFillWithImage:(NSImage *)image
{
    NSSize imageSize = image.size;
    float imageRatio = imageSize.width / imageSize.height;
    float containerRatio = self.imageContainerView.frame.size.width / self.imageContainerView.frame.size.height;
    
    float finalWidth;
    float finalHeight;
    CGRect finalRect;
    if (imageRatio > containerRatio)
    {
        // 16:9
        finalWidth = self.imageContainerView.frame.size.height * imageRatio;
        finalHeight = self.imageContainerView.frame.size.height;
        finalRect = CGRectMake(-(finalWidth - finalHeight)/2, 0, finalWidth, finalHeight);
    }else if (imageRatio == containerRatio)
    {
        finalWidth = self.imageContainerView.frame.size.width;
        finalHeight = self.imageContainerView.frame.size.height;
        finalRect = CGRectMake(0, 0, finalWidth, finalHeight);
    }else
    {
        // 9 : 16
        finalWidth = self.imageContainerView.frame.size.width;
        finalHeight = self.imageContainerView.frame.size.width / imageRatio;
        finalRect = CGRectMake (0, -(finalHeight - finalWidth)/2, finalWidth, finalHeight);
    }
    
    self.artworkImageView.frame = finalRect;
    
}

- (void)setArtworkUrl:(NSURL *)artworkUrl
{
    _artworkUrl = artworkUrl;
    
}
- (void)setArtworkDate:(NSDate *)artworkDate
{
    if (artworkDate)
    {
        _artworkDate = artworkDate;
        [self.timeLabel setStringValue:artworkDate.timeAgoSinceNow];
    }
}
- (void)setArtworkTitle:(NSString *)artworkTitle
{
    if(artworkTitle)
    {
        _artworkTitle = artworkTitle;
        [self.titleLabel setStringValue:artworkTitle];
    }
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected)
    {}
}
- (void)openPage:(NSGestureRecognizer *)sender
{
    [[NSWorkspace sharedWorkspace] openURL:self.artworkUrl];
}

#pragma mark - JZWallPaperCollectionItemViewMouseDelegate
- (void)mouseOutWithSender:(JZWallPaperCollectionItemView *)sender
                     event:(NSEvent *)theEvent
{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context)
     {
         context.duration = 0.2;
         self.blurView.animator.alphaValue = 0;
     }
                        completionHandler:^{
                            self.blurView.hidden = YES;
                            self.blurView.alphaValue = 0;
                        }];
}
- (void)mouseInWithSender:(JZWallPaperCollectionItemView *)sender
                    event:(NSEvent *)theEvent
{
    self.blurView.hidden = NO;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context)
     {
         context.duration = 0.2;
         self.blurView.animator.alphaValue = 1;
     }
                        completionHandler:^{
                            self.blurView.alphaValue = 1;
                        }];
}
- (void)mouseRightClickWithSender:(JZWallPaperCollectionItemView *)sender
                            event:(NSEvent *)theEvent
{
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@""];
    NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:self.artworkTitle action:nil keyEquivalent:@""];
    [menu addItem:item];
    [menu popUpMenuPositioningItem:[[menu itemArray] objectAtIndex:0]
                        atLocation:[self.view convertPoint:[theEvent locationInWindow] fromView:nil]
                            inView:self.view];
}
@end
