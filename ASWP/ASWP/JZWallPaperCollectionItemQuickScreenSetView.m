//
//  JZWallPaperCollectionItemQuickScreenSetView.m
//  ASWP
//
//  Created by Justin Fincher on 2016/11/19.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import "JZWallPaperCollectionItemQuickScreenSetView.h"
#import "JZScreensManager.h"

@implementation JZWallPaperCollectionItemQuickScreenSetView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidChange:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
    [self refresh];
}

- (void)refresh
{
    if (self.buttons)
    {
        for (NSButton *btn in self.buttons)
        {
            btn.action = nil;
            [btn removeFromSuperview];
        }
    }
    self.buttons = [NSMutableArray array];
    NSInteger count = [[[JZScreensManager sharedManager] currentScreens] count];
    for (int i = 0 ; i < count; i++)
    {
        NSButton *btn = [NSButton buttonWithTitle:[NSString stringWithFormat:@"%d",i + 1] target:self action:@selector(btnPressed:)];
        btn.frame = NSMakeRect(2+i * 16, 4, 22, 22);
        btn.bezelStyle = NSBezelStyleCircular;
        btn.controlSize = NSControlSizeMini;
        btn.font = [NSFont systemFontOfSize:7.0f];
        
        [self addSubview:btn];
        [self.buttons addObject:btn];
    }
}

- (void)screenDidChange:(NSNotification *)notification
{
    [self refresh];
}
- (void)btnPressed:(id)sender
{
    NSInteger index = [self.buttons indexOfObject:sender];
    JZScreensModel *model = [[[JZScreensManager sharedManager] currentScreens] objectAtIndex:index];
    [self.delegate smashThatButtonWithScreen:model.screen];
    
}


@end
