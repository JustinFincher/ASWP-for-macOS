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

@interface JZASDataManager : NSObject

+ (id)sharedManager;
- (void)getDataFromASWithResultSuccess:(void (^)(NSDictionary * data))finishBlock
                               failure:(void (^)(NSError * error))errorBlock;
@end
