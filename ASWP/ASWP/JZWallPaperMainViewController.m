//
//  JZWallPaperMainViewController.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperMainViewController.h"
#import "JZASDataManager.h"
#import "JZWallPaperCollectionViewItem.h"

@interface JZWallPaperMainViewController ()<NSCollectionViewDataSource,NSCollectionViewDelegate>
@property (weak) IBOutlet NSCollectionView *wallpapersCollectionView;
@property (strong, nonatomic) NSCollectionViewFlowLayout *flowLayout;


@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation JZWallPaperMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.wallpapersCollectionView registerClass:[JZWallPaperCollectionViewItem class] forItemWithIdentifier:@"JZWallPaperCollectionViewItem"];
    self.wallpapersCollectionView.delegate = self;
    self.wallpapersCollectionView.dataSource = self;
    self.flowLayout = [[NSCollectionViewFlowLayout alloc] init];
    
    self.flowLayout.sectionInset = NSEdgeInsetsMake(70, 0, 70, 0);
    self.flowLayout.estimatedItemSize = CGSizeMake(self.view.frame.size.width / 3, self.view.frame.size.width / 3);
    
    self.flowLayout.minimumInteritemSpacing = 0.0f;
    self.flowLayout.minimumLineSpacing = 0.0f;
    self.wallpapersCollectionView.collectionViewLayout = self.flowLayout;
    
    [[JZASDataManager sharedManager] getDataFromASWithResultSuccess:^(NSMutableArray *array)
    {
        [self setDataSource:array];
    } failure:^(NSError *error){}];
}

- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [self.wallpapersCollectionView reloadData];
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
- (NSCollectionViewItem *)collectionView:(NSCollectionView *)collectionView itemForRepresentedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    JZWallPaperCollectionViewItem *item = (JZWallPaperCollectionViewItem *)[self.wallpapersCollectionView makeItemWithIdentifier:@"JZWallPaperCollectionViewItem" forIndexPath:indexPath];

    JZASArtworkModel *model = [self.dataSource objectAtIndex:indexPath.item];
    [item setArtworkUrl:model.artworkLink];
    return item;
}

@end
