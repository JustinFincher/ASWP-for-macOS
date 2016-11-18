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
#import "JZWallPaperCollectionViewItem.h"

@interface JZWallPaperMainViewController ()<NSCollectionViewDataSource,NSCollectionViewDelegate>
@property (weak) IBOutlet NSScrollView *wallpapersScrollView;
@property (weak) IBOutlet NSCollectionView *wallpapersCollectionView;
@property (strong, nonatomic) NSCollectionViewFlowLayout *flowLayout;

@property (weak) IBOutlet NSVisualEffectView *topVIsualEffectView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak) IBOutlet NSButton *refreshButton;

@end

@implementation JZWallPaperMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.topVIsualEffectView.wantsLayer = YES;
    self.view.wantsLayer = YES;
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
    
    [[JZASDataManager sharedManager] getDataFromASWithResultSuccess:^(NSMutableArray *array)
    {
        [self setDataSource:array];
    } failure:^(NSError *error){}];
}

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [self.wallpapersCollectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    if (self.dataSource.count > 0)
    {
        [NSAnimationContext beginGrouping];
        [[NSAnimationContext currentContext] setDuration:2.0];
        [[self.wallpapersCollectionView animator] scrollToItemsAtIndexPaths:[NSSet setWithObjects:[NSIndexPath indexPathForItem:0 inSection:0], nil] scrollPosition:NSCollectionViewScrollPositionTop];
        [NSAnimationContext endGrouping];
    }

}
- (IBAction)refreshButtonPressed:(id)sender
{
    self.refreshButton.enabled = NO;
    [[JZASDataManager sharedManager] getDataFromASWithResultSuccess:^(NSMutableArray *array)
     {
         [self setDataSource:array];
         self.refreshButton.enabled = YES;
     } failure:^(NSError *error)
     {
         self.refreshButton.enabled = YES;
     }];
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
@end
