//
//  JZWallPaperMainViewController.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperMainViewController.h"
#import "JZASDataManager.h"

@interface JZWallPaperMainViewController ()

@end

@implementation JZWallPaperMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [[JZASDataManager sharedManager] getDataFromASWithResultSuccess:^(NSDictionary *data)
    {
        NSLog(@"%@",data);
        
    } failure:^(NSError *error){}];
}

@end
