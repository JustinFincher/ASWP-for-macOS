//
//  JZWallPaperMainViewController.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperMainViewController.h"
#import "JZWallPaperCollectionHeaderView.h"
#import "JZASDataManager.h"
#import <QuartzCore/QuartzCore.h>
#import "JZWallPaperManager.h"
#import "JZSettingsViewController.h"
#import "JZWallPaperCollectionViewItem.h"
#import "JZLaunchOnLoginManager.h"
#import "AppDelegate.h"

@interface JZWallPaperMainViewController ()<NSCollectionViewDataSource,NSCollectionViewDelegate>
@property (weak) IBOutlet NSScrollView *wallpapersScrollView;
@property (weak) IBOutlet NSCollectionView *wallpapersCollectionView;
@property (strong, nonatomic) NSCollectionViewFlowLayout *flowLayout;

@property (weak) IBOutlet NSVisualEffectView *topVIsualEffectView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak) IBOutlet NSButton *refreshButton;
@property (weak) IBOutlet NSButton *settingsButton;

@end

@implementation JZWallPaperMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.topVIsualEffectView.wantsLayer = YES;
    self.view.wantsLayer = YES;
    [self.view.layer setBackgroundColor:[NSColor clearColor].CGColor];
    self.wallpapersScrollView.wantsLayer = YES;
    [self.wallpapersScrollView.layer setBackgroundColor:[NSColor clearColor].CGColor];
    self.wallpapersCollectionView.wantsLayer = YES;
    self.wallpapersCollectionView.backgroundColors = @[[NSColor clearColor]];

    
    
    [self.wallpapersCollectionView registerClass:[JZWallPaperCollectionViewItem class] forItemWithIdentifier:@"JZWallPaperCollectionViewItem"];
    [self.wallpapersCollectionView registerClass:[JZWallPaperCollectionHeaderView class] forSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:@"JZWallPaperCollectionHeaderView"];
    self.wallpapersCollectionView.delegate = self;
    self.wallpapersCollectionView.dataSource = self;
    self.flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    self.flowLayout.sectionInset = NSEdgeInsetsZero;
    self.flowLayout.estimatedItemSize = CGSizeMake(self.view.frame.size.width / 3, self.view.frame.size.width / 3);
    
    self.flowLayout.minimumInteritemSpacing = 0.0f;
    self.flowLayout.minimumLineSpacing = 0.0f;
    self.wallpapersCollectionView.collectionViewLayout = self.flowLayout;
    
    [self.wallpapersScrollView setHasVerticalScroller:YES];
    [[self.wallpapersScrollView verticalScroller] setAlphaValue:0];
    
    self.refreshButton.wantsLayer = YES;
    
    [[JZASDataManager sharedManager] getDataFromASWithDirectCache:YES ResultSuccess:^(NSMutableArray *array)
    {
        [self setDataSource:array];
    } failure:^(NSError *error)
    {
        [[JZASDataManager sharedManager] getDataFromASWithDirectCache:NO ResultSuccess:^(NSMutableArray *array)
         {
             [self setDataSource:array];
         } failure:^(NSError *error)
         {
             
         }];
    }];
}


- (void)setDataSource:(NSMutableArray *)dataSource
{
    if (self.dataSource.count > 0)
    {
        [self.wallpapersCollectionView scrollToItemsAtIndexPaths:[NSSet setWithObjects:[NSIndexPath indexPathForItem:0 inSection:0], nil] scrollPosition:NSCollectionViewScrollPositionTop];
    }
    _dataSource = dataSource;
    [self.wallpapersCollectionView reloadData];
    [self.wallpapersCollectionView setNeedsDisplay:YES];

}
- (IBAction)settingsButtonPressed:(id)sender
{
    NSMenu *settingsMenu = [[NSMenu alloc] initWithTitle:@"Settings"];
    
    NSMenuItem *deleteCacheItem = [[NSMenuItem alloc] initWithTitle:@"Clear Cache" action:@selector(clearCache:) keyEquivalent:@""];
    NSMenuItem *launchOnLoginItem = [[NSMenuItem alloc] initWithTitle:@"Launch On Login" action:@selector(switchLaunchOnLogin:) keyEquivalent:@""];
    [launchOnLoginItem setState: [[JZLaunchOnLoginManager sharedManager] isLaunchOnLogin] ? NSOnState : NSOffState];
    NSMenuItem *aboutItem = [[NSMenuItem alloc] initWithTitle:@"About App" action:@selector(aboutApp:) keyEquivalent:@""];
    NSMenuItem *feedBackItem = [[NSMenuItem alloc] initWithTitle:@"Feedback" action:@selector(goMyBlog:) keyEquivalent:@""];
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit:) keyEquivalent:@""];
    
    [settingsMenu addItem:deleteCacheItem];
    [settingsMenu addItem:[NSMenuItem separatorItem]];
    [settingsMenu addItem:launchOnLoginItem];
    [settingsMenu addItem:[NSMenuItem separatorItem]];
    [settingsMenu addItem:feedBackItem];
    [settingsMenu addItem:aboutItem];
    [settingsMenu addItem:[NSMenuItem separatorItem]];
    [settingsMenu addItem:quitItem];
    [settingsMenu popUpMenuPositioningItem:[[settingsMenu itemArray] objectAtIndex:0]
                                atLocation:CGPointMake(0, 0)
                                    inView:sender];
    
    
}
- (IBAction)refreshButtonPressed:(id)sender
{
    self.refreshButton.enabled = NO;
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.3];
    [[self.wallpapersCollectionView animator] setAlphaValue:0];
    [[NSAnimationContext currentContext] setCompletionHandler:^
    {
        [[JZASDataManager sharedManager] getDataFromASWithDirectCache:NO ResultSuccess:^(NSMutableArray *array)
         {
             [self setDataSource:array];
             self.refreshButton.enabled = YES;
             [NSAnimationContext beginGrouping];
             [[NSAnimationContext currentContext] setDuration:0.3];
             [[self.wallpapersCollectionView animator] setAlphaValue:1];
             [NSAnimationContext endGrouping];
         } failure:^(NSError *error)
         {
             [[JZASDataManager sharedManager] getDataFromASWithDirectCache:YES ResultSuccess:^(NSMutableArray *array)
              {
                  [self setDataSource:array];
                  self.refreshButton.enabled = YES;
                  [NSAnimationContext beginGrouping];
                  [[NSAnimationContext currentContext] setDuration:0.3];
                  [[self.wallpapersCollectionView animator] setAlphaValue:1];
                  [NSAnimationContext endGrouping];
              } failure:^(NSError *error)
              {
                  
              }];
         }];
    }];
    [NSAnimationContext endGrouping];
}

#pragma mark - NSCollectionViewDataSource
- (NSInteger)collectionView:(NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource)
    {
        return self.dataSource.count;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(NSCollectionView *)collectionView
{
    return 1;
}
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    JZWallPaperCollectionViewItem *item = (JZWallPaperCollectionViewItem *)[self.wallpapersCollectionView makeItemWithIdentifier:@"JZWallPaperCollectionViewItem" forIndexPath:indexPath];

    JZASArtworkModel *model = [self.dataSource objectAtIndex:indexPath.item];
    [item setArtworkUrl:model.artworkLink];
    [item setArtworkImageUrl:model.artworkImageLink];
    [item setArtworkTitle:model.artworkTitle];
    [item setArtworkDate:model.artworkPubDate];
    return item;
}
- (NSView *)collectionView:(NSCollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:NSCollectionElementKindSectionHeader])
    {
        JZWallPaperCollectionHeaderView *view = [self.wallpapersCollectionView makeSupplementaryViewOfKind:NSCollectionElementKindSectionHeader withIdentifier:@"JZWallPaperCollectionHeaderView" forIndexPath:indexPath];
        return view;
    }
    return nil;
}
#pragma mark - NSCollectionViewDelegateFlowLayout
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return NSZeroSize;
}
- (NSSize)collectionView:(NSCollectionView *)collectionView layout:(NSCollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return NSZeroSize;
}
#pragma mark - Settings Actions
- (void)clearCache:(id)sender
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Sure To Clear Cache?"];
    [alert setInformativeText:@"You may lose current wallpaper set from this app after you re-login the system."];
    [alert addButtonWithTitle:@"Sure"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setAlertStyle:NSWarningAlertStyle];
    if ([alert runModal] == NSAlertFirstButtonReturn)
    {
        [[JZWallPaperManager sharedManager] clearAllCacheAndSaved];
    }else
    {
        
    }
}
- (void)aboutApp:(id)sender
{
  [[NSApplication sharedApplication] orderFrontStandardAboutPanel:sender];
}
- (void)goMyBlog:(id)sender
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.justzht.com"]];
}
- (void)quit:(id)sender
{
    [NSApp performSelector:@selector(terminate:) withObject:nil afterDelay:0.0];
}
- (void)switchLaunchOnLogin:(id)sender
{
    BOOL oldState = [[JZLaunchOnLoginManager sharedManager] isLaunchOnLogin];
    [[JZLaunchOnLoginManager sharedManager] setLaunchOnLogin:!oldState completeHandler:^(void)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:[NSString stringWithFormat:@"Successfully %@ Launch On Login", (oldState ? @"Disable":@"Enable")] ];
        [alert setInformativeText:@""];
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertStyle:NSAlertStyleInformational];
        [alert runModal];
    } error:^(void)
    {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:[NSString stringWithFormat:@"Error When Try to %@ Launch On Login", (oldState ? @"Disable":@"Enable")] ];
        [alert setInformativeText:@"Please try again, if this still occurs please re-login the system"];
        [alert addButtonWithTitle:@"OK"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
    }];
}
@end
