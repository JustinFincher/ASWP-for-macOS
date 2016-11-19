//
//  JZASDataManager.h
//  ASWP
//
//  Created by Justin Fincher on 2016/11/18.
//  Copyright © 2016年 Justin Fincher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "XMLDictionary.h"
#import "JZASArtworkModel.h"

@interface JZASDataManager : NSObject

+ (id)sharedManager;

- (void)getDataFromASWithDirectCache:(BOOL)directCache
                       ResultSuccess:(void (^)(NSMutableArray * array))finishBlock
                             failure:(void (^)(NSError * error))errorBlock;

@end
